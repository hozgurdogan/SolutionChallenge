import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import '../models/Organization.dart';

class OrganizationService {
  final auth = FirebaseAuth.instance;
  final firebaseStore = FirebaseFirestore.instance;


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
      //organization.endDate=event["endDate"];
      //organization.startDate=event["startDate"];
      organization.city = event["city"];
      organization.town = event["town"];
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
      GeoPoint location = documentSnapshot["location"];
      organization.latitude = location.latitude;
      organization.longitude = location.longitude;
    }

    return organization;
  }
}
