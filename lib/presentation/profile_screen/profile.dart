import 'dart:math';

import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/models/Organization.dart';
import 'package:ahmet_s_application2/models/UserInfo.dart';
import 'package:ahmet_s_application2/presentation/accept_event_screen/EventAccept.dart';
import 'package:ahmet_s_application2/presentation/editprofile_screen/editprofilenew.dart';
import 'package:ahmet_s_application2/service/OrganizationService.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_title_button.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'package:ahmet_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:ahmet_s_application2/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

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
  const ProfilePage();

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();


  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: _buildAppBar(context),
        body: FutureBuilder<InfoUser>(
            future: UserService().getUserInfoByEmail(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Veri yüklenene kadar yükleniyor göstergesi göster.
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Hata varsa hata mesajını göster.
                return Center(child: Text('Hata: ${snapshot.error}'));
              }else {
                var log=Logger();
            //    log.d("geleen degeer"+snapshot.data!.activities!.first.title!);
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        _buildTenStack(context),
                        Text(
                          snapshot.data!.name! + " " + snapshot.data!.surname!,
                        ),
                        SizedBox(height: 2.v),
                        Text(
                          "@"+snapshot.data!.username!,
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
                                children:[ Text(
                                   snapshot.data!.score!.toString(),
                                  style: theme.textTheme.labelSmall,
                                ),
                                  Icon(Icons.star,color: Colors.amber,)
                    ]
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
                                    padding: EdgeInsets.only(left:30.h),
                                    child: Text(
                                      snapshot.data!.activities!.length.toString(),
                                      style: theme.textTheme.titleSmall,
                                    ),
                                  ),
                                  Text(
                                    "Joined Activities",
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
                                    snapshot.data!.attendedActivities!.length.toString(),
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
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    selectedIndex = 0;
                                  });
                                },
                                style: ButtonStyle(),
                                child: Text("Joined Events"),


                              ),

                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    selectedIndex = 1;
                                  });
                                },
                                style: ButtonStyle(),
                                child: Text("Attended Events"),
                                //text: "Attended Events",
                              //  width: 80.h,
                               // height: 20.h,
                               // buttonStyle: selectedIndex == 1
                                //    ? CustomButtonStyles.fillGray
                                 //   : null,

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

                        _buildEventCardRow(context, selectedIndex == 0 ? snapshot.data!.activities : snapshot.data!.attendedActivities),
                        SizedBox(height: 5.v),
                      ],
                    ),
                  ),
                );
              }
            }),
          bottomNavigationBar: Padding(
              padding: EdgeInsets.only(left: 14.h, right: 11.h),
              child: _buildBottomBar(context)),

      );

    }



  Widget _buildEventCardRow(BuildContext context, List<Organization>? activities) {
    var log=Logger();
    log.d(activities?.length.toString());

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: activities?.length ?? 0,
      itemBuilder: (context, index) {
        final activity = activities![index];
        return Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(bottom: 20.h),
            decoration: AppDecoration.fillGray300.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder20,
            ),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgRectangle14,
                  height: 120.v,
                  width: 150.h,
                  radius: BorderRadius.circular(
                    10.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 7.h,
                    top: 7.v,
                    bottom: 7.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 16.h),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              activities[index].title!,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 11.v),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomImageView(
                            imagePath:
                            ImageConstant.imgFluentMdl2DateTime,
                            height: 15.adaptSize,
                            width: 15.adaptSize,
                            margin: EdgeInsets.only(top: 1.v),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 1.h,
                              top: 1.v,
                              bottom: 3.v,
                            ),
                            child: Text(
                              DateFormat.yMMMM().format(activities[index].startDate!),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgCodiconLocation,
                            height: 15.adaptSize,
                            width: 15.adaptSize,
                            margin: EdgeInsets.only(left: 5.h),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 1.v,
                              bottom: 3.v,
                            ),
                            child: Text(
                              activities[index].town!,
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.v),
                      Container(
                        width: 125.h,
                        margin: EdgeInsets.only(right: 15.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                              EdgeInsets.only(top: 4.v, left: 15.v),
                              child: Text(
                                DateFormat.Hm().format(
                                    activities[index].startDate!),
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            Spacer(),
                            // CustomImageView(
                            //   imagePath: ImageConstant.imgHealthiconsAwa,
                            //   height: 15.adaptSize,
                            //   width: 15.adaptSize,
                            // ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 4.v,
                                bottom: 3.v,
                              ),
                              child: Text(
                                activities[index].score!
                                    .toString() +
                                    " Puan",
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.v),
                      SizedBox(
                        height: 50.h,
                        width: 250.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 1.v,
                                  right: 8.h,
                                ),
                                padding: EdgeInsets.all(4.h),
                                decoration:
                                AppDecoration.fillGray.copyWith(
                                  borderRadius:
                                  BorderRadiusStyle.roundedBorder12,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: Text(
                                        "Detay",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailstwoScreen(
                                                        organizationID:
                                                        activities
                                                        [
                                                        index]
                                                            .id)));
                                      },
                                    ),
                                    if (selectedIndex == 1) ...[
                                      Row(children: [
                                        SizedBox(width: 10.h),
                                        IconButton(onPressed:
                                            (){}, icon: Icon(Icons.delete,color: Colors.red,)),
                                        SizedBox(width: 30.h),
                                        TextButton(onPressed: (){
                                          //OrganizationService().getParticipantsByOrganizationId(activities![index].id!);

                                          Navigator.of(context).push(MaterialPageRoute(builder:
                                              (context) => AcceptEvent(organizationId: activities![index].id!),));


                                        }, child: Text("Katılımcıları Onayla",style: TextStyle(fontSize: 10),)),


                                      ],)

                                    ],
                                  ],



                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
















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
  Widget _buildTenStack(BuildContext context) {
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
              // decoration: AppDecoration.outlineIndigo.copyWith(
              //   borderRadius: BorderRadiusStyle.roundedBorder67,
              // ),
              // child: CustomImageView(
              //   imagePath: ImageConstant.imgEllipse2,
              //   height: 130.adaptSize,
              //   width: 130.adaptSize,
              //   radius: BorderRadius.circular(
              //     65.h,
              //   ),
              //   alignment: Alignment.center,
              // ),
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








