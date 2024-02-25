

import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/models/Organization.dart';

class InfoUser{


  String? name;

  String? surname;
  String? username;
  String? email;
  String? password;
  int? score;
  String? picture;
   List<Organization> acivities=[];
   List<Organization> attendedActivities=[];


   String getProfilePicturePath()
   {

     if(picture=="ahmet.jpg")
       {
         return ImageConstant.ahmet;
       }
     if(picture=="oguz.jpg")
     {
       return ImageConstant.oguz;
     }if(picture=="furkan.jpg")
     {
       return ImageConstant.furkan;
     }if(picture=="ozgur.jpg")
     {
       return ImageConstant.ozgur;
     }
     return ImageConstant.user;
   }


}