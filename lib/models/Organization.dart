import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'UserInfo.dart';



class Organization
{

  String ? id;
  int? score;
  String? title;
  String? description;
  String? city;
  String? town;
  InfoUser? user = InfoUser();
  DateTime? startDate;
  DateTime? endDate;
  double? latitude;
  double? longitude;
  late List<InfoUser?>participants;

}