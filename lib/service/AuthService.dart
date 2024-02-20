import 'package:ahmet_s_application2/presentation/details_bottomsheet/details_bottomsheet.dart';
import 'package:ahmet_s_application2/presentation/details_bottomsheet/widgets/eventlist_item_widget.dart';
import 'package:ahmet_s_application2/presentation/detailstwo_screen/widgets/eventlist1_item_widget.dart';
import 'package:ahmet_s_application2/presentation/login_screen/login_screen.dart';
import 'package:ahmet_s_application2/presentation/main_page/main_page.dart';
import 'package:ahmet_s_application2/presentation/main_page/widgets/eventcard_item_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

import '../presentation/detailstwo_screen/detailstwo_screen.dart';
import '../routes/app_routes.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<bool> isGoogleSignIn() async {
    User? user = auth.currentUser;
    if (user != null) {
      List<UserInfo> userInfo = user.providerData;
      for (var info in userInfo) {
        print("Provider ıd"+auth.currentUser!.uid!);
        if (info.providerId == 'google.com') {
          return true; // Kullanıcı Google ile giriş yapmış
        }
      }
    }
    return false; // Kullanıcı Google ile giriş yapmamış
  }

 signInWithGoogle(BuildContext context)
  async {
    final GoogleSignInAccount? googleUser=await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth=await googleUser!.authentication;

    final credential=GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken

    );
    UserCredential userCredential=await FirebaseAuth.instance.signInWithCredential(credential);

    QuerySnapshot snapshot=await  firestore.collection("Users").where("email",isEqualTo: userCredential.user?.email).get();

    if(snapshot!.docs!=null)
      {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainPage(),));

      }
    else
      {
        print("İlk defa giriş yaptı");
    final userName = userCredential.user?.displayName; // Kullanıcı adı

    String? firstName;
    String? lastName;

    // Kullanıcı adı "Ad Soyad" formatındaysa
    if (userName != null && userName.contains(' ')) {
      final nameParts = userName.split(' ');
      firstName = nameParts[0];
      lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : null;
    } else {
      firstName = userName;
    }

      if(userCredential.user !=null)
        {
          await firestore.collection('Users').doc(userCredential.user!.uid).set({
            'email': userCredential.user!.email,
            'name': firstName,
            'score': 0, // Kayıt yapılırken başlangıç puanı olarak 0 atandı
            'surname': lastName,
            'username': "",
            'activities': [],
             'attendedEvents':[],   // Kullanıcının aktiviteleri için boş bir liste oluşturuldu
          });


          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainPage(),));
        }
      }
  }


  bool logOut()
  {
    auth.signOut();
    if(auth.currentUser==null)
      {
       return true;
      }
    return false;
  }

      //Login function with mail and password
  Future<void> login({required BuildContext context,
    required String email,
    required String password}) async {
    try {
      var logger = Logger();
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MainPage()));
      }
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(msg: "Bu bilgilerde bir kullanıcı yok");
    }
  }
  Future<void> register({
    required BuildContext context,
    required String name,
    required String surname,
    required String username,
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {
    try {
      if (password == passwordConfirm) {
        final UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (userCredential.user != null) {
          // Firebase Authentication'a kullanıcı eklendi, şimdi Firestore'a ekleyelim
          await firestore.collection('Users').doc(userCredential.user!.uid).set({
            'email': email,
            'name': name,
            'password': password,
            'score': 0, // Kayıt yapılırken başlangıç puanı olarak 0 atandı
            'surname': surname,
            'username': username,
            'activities': [],
            'attendedEvents': [], // Kullanıcının aktiviteleri için boş bir liste oluşturuldu
// Kullanıcının aktiviteleri için boş bir liste oluşturuldu
          });

          // Kullanıcıyı etkinlik listesine ekle

        }

        Navigator.pushNamed(context, AppRoutes.loginScreen);
      } else {
        Fluttertoast.showToast(msg: "Şifreler uyuşmuyor");
      }
    } catch (error) {
      print('Error registering user: $error');
      Fluttertoast.showToast(msg: "Bir hata oluştu. Lütfen tekrar deneyin.");
    }
  }

  void register2({
    required BuildContext context,
    required String name,
    required String surname,
    required String username,
    required String email,
    required String password,
    required String passwordConfirm,
  }) {
    try {


    } catch (error) {}
  }

  //Login with google account(not completed)
  Future<void> loginWithGoogleAccount(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn
          .signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
            .authentication;

        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        await auth.signInWithCredential(authCredential);
        Navigator.pushNamed(context, "/home");
      }
    } catch (error) {

    }
  }

// Function to check if the email exists in the database
  Future<bool> isEmailTaken(String email) async {
    try {
      List<String> signInMethods = await auth.fetchSignInMethodsForEmail(email);

      if (signInMethods.isEmpty != false) {
        return true;
      }
      return false;
    } catch (error) {}
    return false;
  }

  Future<bool> isUsernameTaken(String username) async {
    return false;
  }

}
