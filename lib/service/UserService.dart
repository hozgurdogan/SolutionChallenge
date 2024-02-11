import 'package:ahmet_s_application2/models/UserInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';




class UserService{


  FirebaseFirestore userCollection = FirebaseFirestore.instance;
  final auth=FirebaseAuth.instance;


  //get user by currentUser email
  Future<InfoUser> getUserInfoByEmail()async
  {    var logger=Logger();


    final currentUser=auth.currentUser;

  QuerySnapshot  querySnapshot=await userCollection.collection("Users").where('email',isEqualTo: currentUser!.email).get();
  InfoUser user=InfoUser();

  if(querySnapshot.docs.isNotEmpty)
    {
      DocumentSnapshot documentSnapshot=querySnapshot.docs.first;
      user.name=documentSnapshot["name"];
      user.surname=documentSnapshot["surname"];
      user.email=documentSnapshot["email"];
      user.score=documentSnapshot["score"];
      user.username=documentSnapshot["username"];

      }

    return user;
  }




}