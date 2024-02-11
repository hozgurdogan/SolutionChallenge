import 'package:ahmet_s_application2/presentation/details_bottomsheet/details_bottomsheet.dart';
import 'package:ahmet_s_application2/presentation/details_bottomsheet/widgets/eventlist_item_widget.dart';
import 'package:ahmet_s_application2/presentation/detailstwo_screen/widgets/eventlist1_item_widget.dart';
import 'package:ahmet_s_application2/presentation/main_page/main_page.dart';
import 'package:ahmet_s_application2/presentation/main_page/widgets/eventcard_item_widget.dart';
import 'package:ahmet_s_application2/presentation/profile_screen/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

import '../presentation/detailstwo_screen/detailstwo_screen.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;


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

  void register({
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
