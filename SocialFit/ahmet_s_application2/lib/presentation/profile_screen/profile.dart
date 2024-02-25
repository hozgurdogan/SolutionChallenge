import 'dart:math';

import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/models/Organization.dart';
import 'package:ahmet_s_application2/presentation/accept_event_screen/EventAccept.dart';
import 'package:ahmet_s_application2/presentation/award_page/award_page.dart';
import 'package:ahmet_s_application2/presentation/editprofile_screen/editprofilenew.dart';
import 'package:ahmet_s_application2/presentation/profile_screen/health.dart';
import 'package:ahmet_s_application2/presentation/profile_screen/new.dart';
import 'package:ahmet_s_application2/service/OrganizationService.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_title_button.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'package:ahmet_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:ahmet_s_application2/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../models/InfoUser.dart';
import '../../service/UserService.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/app_bar/appbar_title_button.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../detailstwo_screen/detailstwo_screen.dart';
import '../editprofile_screen/editprofile_screen.dart';


class ProfilePage extends StatefulWidget {
  ProfilePage();

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  InfoUser userInfo=InfoUser(); // null olabilen userInfo değişkeni

  @override
  void initState() {

    super.initState();
    // UserInfo nesnesini başlangıçta null olarak tanımlıyoruz
    // Verileri çekmek için metodumuzu çağırıyoruz.
    _fetchUserInfo();
  }



// Verileri çeken metod
  void _fetchUserInfo() async {
    try {

      // Verileri çekmek için UserService sınıfını kullanıyoruz.
      InfoUser userData = await UserService().getUserInfoByEmail();
      setState(() {
        // Çekilen verileri state içinde güncelliyoruz.
        userInfo = userData;


      });
    } catch (error) {
      // Hata durumunda burası çalışacak
      print('Hata: $error');
    }
  }







  GlobalKey<NavigatorState> navigatorKey = GlobalKey();


  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      resizeToAvoidBottomInset: false,
      body: FutureBuilder<InfoUser>(
        future: UserService().getUserInfoByEmail(), // Verileri getiren asenkron fonksiyonu buraya koyun
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Veriler yüklenirken yükleme göstergesi göster
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Hata durumunda hata mesajını göster
            return Center(
              child: Container(
                  color: HexColor("FFFCF2"),

                  child: Text('Hata: ${snapshot.error}')),
            );
          } else {
            // Veriler başarıyla yüklendiğinde sayfayı göster
            userInfo = snapshot.data!; // Verileri al
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                color: HexColor("FFFCF2"),
                child: SizedBox(

                  width: double.maxFinite,
                  child: Column(
                    children: [
                      _buildTenStack(context,userInfo.getProfilePicturePath()),
                      Text(
                        userInfo.name! + " " + userInfo.surname!,
                      ),
                      SizedBox(height: 2.v),
                      Text(
                        "@" + userInfo.username!,
                        style: theme.textTheme.labelSmall,
                      ),
                      SizedBox(height: 4.v),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgCodiconLocation,
                            height: 15.adaptSize,
                            width: 15.adaptSize,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.v),
                            child: Row(
                              children: [
                                Text(
                                  userInfo.score!.toString(),
                                  style: theme.textTheme.labelSmall,
                                ),
                                Icon(Icons.star, color: Colors.amber)
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.v),
                      _buildEditProfileButton(context),
                      SizedBox(height: 4.v),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 96.h,
                          right: 78.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 30.h),
                                  child: Text(
                                    userInfo.acivities!.length.toString(),
                                    style: theme.textTheme.titleSmall,
                                  ),
                                ),
                                Text(
                                  "My Activities",
                                  style: CustomTextStyles.bodySmallBlack900,
                                ),
                              ],
                            ),
                            Spacer(
                              flex: 50,
                            ),
                            Spacer(
                              flex: 50,
                            ),
                            Column(
                              children: [
                                Text(
                                  userInfo.attendedActivities!.length.toString(),
                                  style: theme.textTheme.titleSmall,
                                ),
                                Text(
                                  "Attended Events",
                                  style: CustomTextStyles.bodySmallBlack900,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 23.v),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 66.h,
                          right: 62.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: selectedIndex == 0 ? appTheme.brownL.withOpacity(0.5) : null,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    selectedIndex = 0;
                                  });
                                },
                                style: ButtonStyle(),
                                child: Text("My Activities"),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: selectedIndex == 1 ? appTheme.brownL.withOpacity(0.5) : null,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    selectedIndex = 1;
                                  });
                                },
                                style: ButtonStyle(),
                                child: Text("Attended Activities"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.v),
                      Divider(
                        indent: 38.h,
                        endIndent: 37.h,
                      ),
                      SizedBox(height: 10.v),
                      _buildEventCardRow(context, selectedIndex == 0 ? userInfo.acivities : userInfo.attendedActivities),
                      SizedBox(height: 5.v),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 14.h, right: 11.h),
        child: _buildBottomBar(context),
      ),
    );
  }




  Widget _buildEventCardRow(BuildContext context, List<Organization>? activities) {
    if (activities == null || activities.isEmpty) {
      return Center(child: Text("No activities"));
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final activity = activities[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: HexColor("CCC5B9"),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title!,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Icon(Icons.star, color: HexColor("EB5E28")),
                    Text(
                      activity.score!.toString() + " Point",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(width: 20.0),
                    Icon(Icons.calendar_today),
                    Text(
                      DateFormat.yMMMMd().format(activity.startDate!),
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (selectedIndex == 0) ...[
                      IconButton(
                        icon: Icon(Icons.delete,size: 15,),
                        color: Colors.red,
                        onPressed: () async {
                          await OrganizationService().getUsersSortedByScore();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AwardPage(),
                          ));
                        },
                      ),
                      Container(
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: HexColor("FFFCF2").withOpacity(0.9),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextButton(
                          onPressed: () {
                            print("AVDA.)");

                            print("AVDA"+activity.id!);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  AcceptEvent(organizationId: activity.id!),
                            ));
                          },
                          child: Text("Accept Participants",style: TextStyle(fontSize: 7),),
                        ),
                      ),

                    ],
                    Container(
                      height: 30.h,
                      decoration: BoxDecoration(
                          color: HexColor("FFFCF2").withOpacity(0.9),
                          borderRadius: BorderRadius.circular(8.0))
                      ,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                Heal(organization: activity),
                          ));
                        },
                        child: Text("Go Analyze",style: TextStyle(fontSize: 10),),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DetailstwoScreen(
                                organizationID: activity.id!,
                              ),
                        ));
                      },
                      child: Text("Details"),
                    ),

                  ],
                ),
              ],
            ),
          );
        },
      );
    }
  }

}



















String getCurrentRoute(BottomBarEnum type) {
  switch (type) {
    case BottomBarEnum.Home:
      return AppRoutes.mainPage;
    case BottomBarEnum.Score:
      return "/";
    case BottomBarEnum.Profile:
      return "/";
    default:
      return "/";
  }
}







PreferredSizeWidget _buildAppBar(BuildContext context) {
  return CustomAppBar(
    title: AppbarTitleButton(

      margin: EdgeInsets.only(left: 25.h),
    ),
    actions: [
      Row(
          children:


          [
            // AppbarTrailingImage(
            //   imagePath: ImageConstant.imgArrowLeft,
            //   margin: EdgeInsets.symmetric(
            //     horizontal: 12.h,
            //     vertical: 14.v,
            //   ),
            // ),




          ]
      ),
    ],
    styleType: Style.bgFill,
  );
}

/// Section Widget
Widget _buildTenStack(BuildContext context, String profile) {
  return SizedBox(
    height: 249.v,
    width: double.maxFinite,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgRectangle2,
          height: 174.v,
          width: 375.h,
          alignment: Alignment.topCenter,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 135.adaptSize,
            width: 135.adaptSize,
            padding: EdgeInsets.all(1.h),
            decoration: AppDecoration.fillGray100.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder5,
            ),
            child: Container(
              decoration: AppDecoration.outlineDeepPurpleA
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder5),
              child:
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    profile ),
              ),


              ),
            ),
          ),

      ],
    ),
  );
}

/// Section Widget
Widget _buildEditProfileButton(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditprofileScreen2(),
      ));
    },
    child:Text( "Edit Profile"),

    // buttonStyle: CustomButtonStyles.fillTealTL8,
  );
}

/// Section Widget
Widget _buildEventDetailsButton(BuildContext context) {
  return Expanded(
    child: CustomElevatedButton(
      text: "Details",buttonTextStyle: TextStyle(fontSize: 12,color: Colors.black),
      margin: EdgeInsets.only(
        top: 1.v,
        right: 6.h,
      ),

      buttonStyle: CustomButtonStyles.fillGray,
    ),
  );
}

/// Section Widget
Widget _buildEventEditButton(BuildContext context) {
  return Expanded(
    child: CustomElevatedButton(
      text: "Edit",buttonTextStyle: TextStyle(fontSize: 12,color: Colors.black),
      margin: EdgeInsets.only(left: 6.h),
      leftIcon: Container(
        margin: EdgeInsets.only(right: 3.h),
        // child: CustomImageView(
        //   imagePath: ImageConstant.imgBitcoiniconseditoutlineBlack900,
        //   height: 15.adaptSize,
        //   width: 15.adaptSize,
        // ),
      ),
    ),
  );
}

/// Section Widget