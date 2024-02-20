import 'dart:developer';

import 'package:ahmet_s_application2/models/UserInfo.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../models/Organization.dart';

class OrganizationService {
  final auth = FirebaseAuth.instance;
  final firebaseStore = FirebaseFirestore.instance;

  Future<void> checkUserLoginStatus() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        print("Kullanıcı giriş yapmış.");
        print("Giriş bilgileri:");
        print("UID: ${user.uid}");
        print("Email: ${user.email}");
        // Giriş bilgilerini doldurmak için diğer gereken bilgileri burada da alabilirsiniz.
      } else {
        print("Kullanıcı giriş yapmamış.");
      }
    } catch (e) {
      print("Giriş durumu kontrol edilirken bir hata oluştu: $e");
    }
  }

    Future<void> joinOrganization(String id) async {
      try {
        // Giriş durumunu kontrol et
        await checkUserLoginStatus();

        // Kullanıcıyı al
        User? user = auth.currentUser;
        if (user == null) {
          throw Exception("Kullanıcı oturum açmamış.");
        }

        // Organizasyonun varlığını kontrol et
        Organization organization =
            await getOrganizationDetail(organizationId: id);

        if (organization.id == null) {
          throw Exception("Belirtilen ID'ye sahip organizasyon bulunamadı.");
        }
          print("geldi geldi");
        DocumentReference eventRef = firebaseStore.collection('Events').doc(id);
        DocumentReference userRef = firebaseStore.collection('Users').doc(user.uid!);

        print("aaa1"+eventRef.path);
        // Kullanıcının activities alanına organizasyonu ekle
        await firebaseStore.collection('Users').doc(user.uid).update({
          'attendedEvents': FieldValue.arrayUnion([eventRef]),
        });
        await firebaseStore.collection('Events').doc(id).update({
          'participants': FieldValue.arrayUnion([userRef]),
        });

        Map<String, dynamic> userEntry = {
          'user': userRef,
          'katıl': false,
        };
        await firebaseStore.collection('Events').doc(id).update({
          'partts': FieldValue.arrayUnion([userEntry]),
        });





      } catch (e) {
        print("Hata oluştu: $e");
        // Hata durumunda gerekli işlemler yapılabilir, örneğin bir hata mesajı gösterilebilir
      }
    }


  Future<List<InfoUser>> getUsersSortedByScore() async {
    List<InfoUser> sortedUsers = [];

    QuerySnapshot usersSnapshot = await FirebaseFirestore.instance.collection('Users').orderBy('score', descending: true).get();

    for (var doc in usersSnapshot.docs) {
      var userData = doc.data() as Map<String, dynamic>; // Veri türünü doğru şekilde belirtiyoruz
      if (userData != null) {
        InfoUser userInfo = InfoUser();
        userInfo.name = userData['name'];
        userInfo.surname = userData['surname'];
        userInfo.username = userData['username'];
        userInfo.score = userData['score'];
        sortedUsers.add(userInfo);
      }
    }
      sortedUsers.forEach((element) {
        print("adı"+element.name!+" skor "+ element.score!.toString());
      });
    return sortedUsers;
  }



  getParticipantsByOrganizationId(String organizationId) async {
    Organization organization =
        await getOrganizationDetail(organizationId: organizationId);
    var log = Logger();
    log.d("Kontrol ediliyor..." + organization.participants!.first!.name!);

    List<InfoUser> participants = [];

    organization.participants.forEach((participant) {
      participants.add(participant!);
    });

    log.d("İşlem tamamlandı..." + participants.first.name!);

    return participants;
  }

  acceptUserToOrganization(Organization organization, InfoUser user) async {

    var log = Logger();
    log.d("Puan artıtrıd");

    QuerySnapshot querySnapshot = await firebaseStore
        .collection("Users")
        .where("email", isEqualTo: user.email)
        .get();

    DocumentSnapshot querySnapshotOrg = await firebaseStore
        .collection("Events").doc(organization.id).get();
    List<dynamic> parts = querySnapshotOrg["partts"];


    for (int i = 0; i < parts.length; i++) {
      DocumentReference userRef = parts[i]["user"];
      bool participated = parts[i]["katıl"];

      if (querySnapshot.docs.isNotEmpty) {

        // Kullanıcı bulunduğunda, katıl değerini true olarak güncelle

        String id=querySnapshot.docs.first.id;
        if (userRef.id == id) {

          // Kullanıcı bulunduğunda, katıl değerini true olarak güncelle
          parts[i]["katıl"] = true;

          // Güncellenmiş parts array'i ile birlikte Organization belgesini güncelle
          await firebaseStore.collection("Events").doc(organization.id).update({"partts": parts});
          break;
        }

      }
    }








    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      int currentScore = documentSnapshot["score"] ?? 0;
      int updatedScore = currentScore + organization.score!;

      // Güncellenmiş skor ile birlikte kullanıcı belgesini güncelle
      await firebaseStore
          .collection("Users")
          .doc(documentSnapshot.id)
          .update({"score": updatedScore});
    }
  }

  //Get all activities in the database

  Future<List<Organization>> getAllOrganization() async {
    List<Organization> allOrganizations = [];

    QuerySnapshot querySnapshot =
        await firebaseStore.collection("Events").get();

    querySnapshot.docs.forEach((event) {
      Organization organization = Organization();
      organization.title = event["title"];
      organization.id = event["id"];
      organization.description = event["description"];
      organization.endDate = (event["endDate"] as Timestamp).toDate();
      organization.startDate = (event["startDate"] as Timestamp).toDate();
      organization.city = event["city"];
      organization.town = event["town"];
      organization.score = event["score"];
      allOrganizations.add(organization);
    });

    return allOrganizations;
  }

  //Get activity by activity(organization) ID
  Future<Organization> getOrganizationDetail(
      {required String organizationId}) async {
    var l = Logger();
    QuerySnapshot querySnapshot = await firebaseStore
        .collection("Events")
        .where("id", isEqualTo: organizationId)
        .get();

    Organization organization = Organization();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      List<dynamic> participants = documentSnapshot["partts"] as List<dynamic>;

      for (var participant in participants) {
        DocumentReference reference = participant['user'];
        bool participated = participant['katıl'];

        DocumentSnapshot userSnapshot = await reference.get();
        InfoUser user = InfoUser();
        user.name = userSnapshot["name"];
        user.surname = userSnapshot["surname"];
        user.email = userSnapshot["email"];

        user.password = userSnapshot["password"];
        user.score = userSnapshot["score"];

        organization.parts.add({user: participated});

        // Add other fields as need);

        // DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        //
        //
        // List<dynamic> participants =
        // documentSnapshot["participants"] as List<dynamic>;
        // List<DocumentReference> references = participants
        //     .map((activity) => activity as DocumentReference)
        //     .toList();

        // for(var participant in references)
        //   {
        //     DocumentSnapshot documentSnapshot = await participant.get();
        //     InfoUser user = InfoUser();
        //
        //     user.name=documentSnapshot["name"];
        //     user.surname=documentSnapshot["surname"];
        //     user.email=documentSnapshot["email"];
        //     user.password=documentSnapshot["password"];
        //     user.score=documentSnapshot["score"];
        //         organization.participants.add(user);
        //         var log=Logger();
        //         log.d("PARTICIPANT "+user.name!);
        //
        //
        //   }
      }

      organization.parts.forEach((element) {
        var log = Logger();
        log.d("map tipi şu şekilde" +
            element.keys.first.name! +
            " : " +
            element.values.first.toString());
      });

      organization.id = documentSnapshot["id"];
      organization.score = documentSnapshot["score"];

      organization.title = documentSnapshot["title"];
      DocumentReference references = documentSnapshot["user"];
      DocumentSnapshot snap = await references.get();
      organization.user?.name = snap["name"];
      organization.user?.surname = snap["surname"];
      organization.user?.username = snap["username"];
      organization.user?.email = snap["email"];

      organization.user?.score = snap["score"];
      organization.description = documentSnapshot["description"];
      organization.town = documentSnapshot["town"];
      organization.city = documentSnapshot["city"];
      organization.endDate =
          (documentSnapshot["endDate"] as Timestamp).toDate();
      organization.startDate =
          (documentSnapshot["startDate"] as Timestamp).toDate();
      GeoPoint location = documentSnapshot["location"];
      organization.latitude = location.latitude;
      organization.longitude = location.longitude;
    }
    return organization;
  }
    Future<void> registerEvent({
    required String title,
    required int score,
    required String description,
    required String city,
    required String town,
    required DateTime startDate,
    required DateTime endDate,
    required String userId, // Eventi oluşturan kullanıcı
    required double latitude, // Ekledik
    required double longitude, // Ekledik
    required List<InfoUser?> participants,
    required List<Map<InfoUser, bool>> partts,
  }) async {
    try {
      // Giriş durumunu kontrol et
      await checkUserLoginStatus();

      // Etkinlik için benzersiz bir ID oluştur
      String eventId = firebaseStore.collection('Events').doc().id;

      // Konumu GeoPoint olarak oluştur
      GeoPoint location = GeoPoint(latitude, longitude);
       DocumentReference userRef=firebaseStore.collection('Users').doc(userId!);

      await firebaseStore.collection('Events').doc(eventId).set({
        'id': eventId,
        'title': title,
        'score': score,
        'description': description,
        'city': city,
        'town': town,
        'startDate': startDate,
        'endDate': endDate,
        'location': location, // Konumu GeoPoint olarak kaydet
        'user': userRef,
        'participants': 'Users/$userId',
        'partts': partts,
      });

      // Etkinlik başarıyla kaydedildi mesajını göstermek için bir Toast kullanılabilir
    } catch (error) {
      print('Error registering event: $error');
      // Hata durumunda kullanıcıya uygun bir mesaj göstermek için bir Toast kullanılabilir
    }
  }

}
