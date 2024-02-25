import 'dart:math';

import 'package:ahmet_s_application2/models/Organization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../models/InfoUser.dart';

class UserService {
  FirebaseFirestore userCollection = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  var log = Logger();



  Future<InfoUser> getCurrentUserInfo()
  async {
    InfoUser user=InfoUser();

    QuerySnapshot snaphshot=await userCollection.collection("Users").where("email",isEqualTo: auth.currentUser!.email!).get();
    if(snaphshot.docs.isNotEmpty)
    {
      DocumentSnapshot snapshot=snaphshot.docs.first;
      user.name=snapshot["name"];
      user.surname=snapshot["surname"];
      user.score=snapshot["score"];
      user.picture=snapshot["picture"];


    }

    return user;
  }



  //get user by currentUser email
  Future<InfoUser> getUserInfoByEmail() async {
    final currentUser = auth.currentUser;
    if (currentUser == null) {
      // Oturum açmış bir kullanıcı yoksa, boş bir InfoUser nesnesi döndürün
      return InfoUser();
    }


    final logger = Logger();
    logger.d("Veriyi çekmek için: ${currentUser.email}");

    QuerySnapshot querySnapshot = await userCollection
        .collection("Users")
        .where('email', isEqualTo: currentUser.email)
        .get();

    InfoUser user = InfoUser();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      // activities ve attendedEvents listelerini başlangıçta oluşturun
      user.acivities = [];
      user.attendedActivities = [];

      List<dynamic>? joinActivitiesData = documentSnapshot["activities"];
      List<dynamic>? attendActivities = documentSnapshot["attendedEvents"];

      if (joinActivitiesData != null) {
        for (var activityRef in joinActivitiesData) {
          DocumentSnapshot activitySnapshot = await activityRef.get();
          Organization organization = Organization();
            organization.id =activitySnapshot["id"];
          organization.score= activitySnapshot["score"];
          organization.title= activitySnapshot["title"];
          organization.description =activitySnapshot["description"];
          organization.town =activitySnapshot["town"];
          organization.city =activitySnapshot["city"];
          organization.endDate =activitySnapshot["endDate"]?.toDate();
          organization.startDate =activitySnapshot["startDate"]?.toDate();
          organization.latitude =activitySnapshot["location"]?.latitude;
          organization.longitude =activitySnapshot["location"]?.longitude;
          user.acivities!.add(organization);
        }
      }

      if (attendActivities != null) {
        for (var activityRef in attendActivities) {
          DocumentSnapshot activitySnapshot = await activityRef.get();
          Organization organization = Organization();
          organization.id =activitySnapshot["id"];
          organization.score= activitySnapshot["score"];
          organization.title= activitySnapshot["title"];
          organization.description =activitySnapshot["description"];
          organization.town =activitySnapshot["town"];
          organization.city =activitySnapshot["city"];
          organization.endDate =activitySnapshot["endDate"]?.toDate();
          organization.startDate =activitySnapshot["startDate"]?.toDate();
          organization.latitude =activitySnapshot["location"]?.latitude;
          organization.longitude =activitySnapshot["location"]?.longitude;

          user.attendedActivities!.add(organization);
        }
      }

      user.name = documentSnapshot["name"];
      user.surname = documentSnapshot["surname"];
      user.email = documentSnapshot["email"];
      user.score = documentSnapshot["score"];
      user.username = documentSnapshot["username"];
      user.password = documentSnapshot["password"];
      user.picture = documentSnapshot["picture"];
      print("picturrr"+user.picture!);

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

