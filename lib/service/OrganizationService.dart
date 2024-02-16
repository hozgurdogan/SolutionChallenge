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
      Organization organization = await getOrganizationDetail(organizationId: id);

      if (organization.id == null) {
        throw Exception("Belirtilen ID'ye sahip organizasyon bulunamadı.");
      }

      // Kullanıcının activities alanına organizasyonu ekle
      await firebaseStore.collection('Users').doc(user.uid).update({
        'attendedEvents': FieldValue.arrayUnion(['Events/$id']),
      });
    } catch (e) {
      print("Hata oluştu: $e");
      // Hata durumunda gerekli işlemler yapılabilir, örneğin bir hata mesajı gösterilebilir
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
     organization.endDate=(event["endDate"] as Timestamp).toDate();
     organization.startDate=(event["startDate"] as Timestamp).toDate();
      organization.city = event["city"];
     organization.town = event["town"];
     organization.score=event["score"];
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

    l.d("Event Detail"+organizationId);
    Organization organization = Organization();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      organization.id = documentSnapshot["id"];
      organization.score = documentSnapshot["score"];

      organization.title = documentSnapshot["title"];
      DocumentReference reference=documentSnapshot["user"];
      DocumentSnapshot snap=await reference.get();
      organization.user?.name=snap["name"];
      organization.user?.surname=snap["surname"];
      organization.user?.username=snap["username"];
      organization.user?.email=snap["email"];

      organization.user?.score=snap["score"];
      organization.description = documentSnapshot["description"];
      organization.town = documentSnapshot["town"];
      organization.city = documentSnapshot["city"];
      organization.endDate=(documentSnapshot["endDate"] as Timestamp).toDate();
      organization.startDate=(documentSnapshot["startDate"] as Timestamp).toDate();
      GeoPoint location = documentSnapshot["location"];
      organization.latitude = location.latitude;
      organization.longitude = location.longitude;
    }

    return organization;
  }
}
