

import 'package:ahmet_s_application2/core/app_export.dart';

import 'InfoUser.dart';



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
  String? image;

  late List<InfoUser?>participants=[];
  List<Map<InfoUser,bool>>parts=[];

  String getImage()
  {
    if(image=="basket.jpg")
      {
        return ImageConstant.basket;
      }
    if(image=="futbol.jpg")
    {
      return ImageConstant.futbol;
    }
    if(image=="camp.jpg")
    {
      return ImageConstant.camp;
    }
    if(image=="bisiklet.jpg")
    {
      return ImageConstant.bisiklet;
    }
    return ImageConstant.imgRectangle14;
  }
  }

