import 'dart:math';

import 'package:ahmet_s_application2/models/Organization.dart';
import 'package:ahmet_s_application2/models/UserInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class UserService {
  FirebaseFirestore userCollection = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  var log = Logger();

  //get user by currentUser email
  Future<InfoUser> getUserInfoByEmail() async {
    int i = 0;
    var logger = Logger();
    final currentUser = auth.currentUser;

    QuerySnapshot querySnapshot = await userCollection
        .collection("Users")
        .where('email', isEqualTo: currentUser!.email)
        .get();
    InfoUser user = InfoUser();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      List<dynamic> joinActivitiesData =
          documentSnapshot["activities"] as List<dynamic>;
      List<DocumentReference> references = joinActivitiesData
          .map((activity) => activity as DocumentReference)
          .toList();


      List<dynamic> attendActivities =
      documentSnapshot["attendedEvents"] as List<dynamic>;
      List<DocumentReference> attendReferences = attendActivities
          .map((activity) => activity as DocumentReference)
          .toList();

      for(var element in attendReferences)
        {
          DocumentSnapshot documentSnapshot = await element.get();
          Organization organization = Organization();

          organization.id = documentSnapshot["id"];
          organization.score = documentSnapshot["score"];
          organization.title = documentSnapshot["title"];
          organization.description = documentSnapshot["description"];
          organization.town = documentSnapshot["town"];
          organization.city = documentSnapshot["city"];
          organization.endDate = (documentSnapshot["endDate"] as Timestamp).toDate();
          organization.startDate = (documentSnapshot["startDate"] as Timestamp).toDate();
          GeoPoint location = documentSnapshot["location"];
          organization.latitude = location.latitude;
          organization.longitude = location.longitude;

          user.attendedActivities!.add(organization);
        }

      for (var element in references) {
        DocumentSnapshot documentSnapshot = await element.get();
        Organization organization = Organization();

        organization.id = documentSnapshot["id"];
        organization.score = documentSnapshot["score"];
        organization.title = documentSnapshot["title"];
        organization.description = documentSnapshot["description"];
        organization.town = documentSnapshot["town"];
        organization.city = documentSnapshot["city"];
        organization.endDate = (documentSnapshot["endDate"] as Timestamp).toDate();
        organization.startDate = (documentSnapshot["startDate"] as Timestamp).toDate();
        GeoPoint location = documentSnapshot["location"];
        organization.latitude = location.latitude;
        organization.longitude = location.longitude;

        user.activities!.add(organization);
        i++;
      }
      log.d("sonra burasi "+user.activities!.first.title!);

      user.name = documentSnapshot["name"];

      user.surname = documentSnapshot["surname"];

      user.email = documentSnapshot["email"];

      user.score = documentSnapshot["score"];

      user.username = documentSnapshot["username"];

      user.password = documentSnapshot["password"];

      user.activities!.forEach((element) {
        log.d("tştlere" + element.title!);
      });
    }

    return user;
  }

  Future<void> updateUser(InfoUser newUserInfo) async {
    print("geldiii" + newUserInfo!.surname!);
    final user = auth.currentUser;
    // QuerySnapshot querySnapshot = await userCollection
    //     .collection("Users")
    //     .where('email', isEqualTo: user!.email)
    //     .get();

    await userCollection.collection("Users").doc(user!.uid!).update({
      "name": newUserInfo.name,
      "surname": newUserInfo.surname,
      "username": newUserInfo.username,
    });

    //
    // Map<String,dynamic> data={
    //   "name":newUserInfo.name,
    //   "surname":newUserInfo.surname,
    // };
    //
    // await FirebaseFirestore.instance.collection('Users').doc(user?.uid).update(data);
  }




}

