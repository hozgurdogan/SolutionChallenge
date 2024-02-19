import 'package:ahmet_s_application2/models/Organization.dart';
import 'package:flutter/material.dart';

class InfoUser
{
  String? name;
  String? surname;
  String? email;
  String? username;
  String? password;
  List<Organization>?activities=[];
  List<Organization>?attendedActivities=[];

  List<Map<Organization,bool>>katildiklari=[];
  int? score;



}