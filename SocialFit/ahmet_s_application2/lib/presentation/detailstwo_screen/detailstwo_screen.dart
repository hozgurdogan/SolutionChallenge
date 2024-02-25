import 'package:ahmet_s_application2/models/Organization.dart';
import 'package:ahmet_s_application2/presentation/map/locationMap.dart';
import 'package:ahmet_s_application2/service/OrganizationService.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../models/InfoUser.dart';
import '../detailstwo_screen/widgets/eventlist1_item_widget.dart';
import 'dart:async';
import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/presentation/main_page/main_page.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'package:ahmet_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:ahmet_s_application2/widgets/custom_bottom_bar.dart';
import 'package:ahmet_s_application2/widgets/custom_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:readmore/readmore.dart';

// ignore_for_file: must_be_immutable
class DetailstwoScreen extends StatelessWidget {
  final String? organizationID;

  DetailstwoScreen({Key? key, required this.organizationID}) : super(key: key);

  Completer<GoogleMapController> googleMapController = Completer();
  Organization organizationData = Organization();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return
      //  organizationData.user=snapshot.data!.user!;

      Scaffold(
          backgroundColor: HexColor("FFFCF2"),
          appBar: _buildAppBar(context),
          body: FutureBuilder<Organization?>(
              future: OrganizationService()
                  .getOrganizationDetail(organizationId: organizationID!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Veri yüklenene kadar yükleniyor göstergesi göster.
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Hata varsa hata mesajını göster.
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  InfoUser user = InfoUser();
                  user = snapshot.data!.user!;
                  organizationData.user = user;

                  return SingleChildScrollView(
                    child: SizedBox(
                        width: double.maxFinite,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 12.v),
                              Column(children: [
                                _buildEventList(context, snapshot.data!),
                                SizedBox(height: 16.v),
                                _buildDetailCard(context),
                                SizedBox(height: 16.v),
                                Container(
                                  width: 400.h,
                                  height: 400.h,
                                  child: MapScreen(
                                      x: snapshot.data!.latitude!,
                                      y: snapshot.data!.longitude!),
                                ),
                                SizedBox(height: 27.v),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                        padding:
                                        EdgeInsets.only(left: 31.h),
                                        child: Text("Description",
                                            style: CustomTextStyles
                                                .titleSmallBold))),
                                SizedBox(
                                    width: 316.h,
                                    child: ReadMoreText(
                                      snapshot.data!.description!,
                                      trimLines: 2,
                                      colorClickableText: theme
                                          .colorScheme.primaryContainer
                                          .withOpacity(1),
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: "Read More...",
                                      moreStyle:
                                      TextStyle(fontSize: 12,color: Colors.lightBlue),
                                      lessStyle:
                                      TextStyle(fontSize: 12,color: Colors.lightBlue),)),
                                SizedBox(height: 19.v),
                                _buildEventDetails(context)
                              ])
                            ])),
                  );
                }
              }),
          bottomNavigationBar: Padding(
              padding: EdgeInsets.only(left: 14.h, right: 11.h),
              child: _buildBottomBar(context)),
      );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return
      CustomAppBar(
          title: Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: Text("Activity Details",style: TextStyle(fontSize: 20,color: Colors.white),)),
          leadingWidth: 54.h,
          leading: AppbarLeadingImage(

              imagePath: ImageConstant.imgArrowLeft,
              margin: EdgeInsets.only(left: 30.h, top: 13.v, bottom: 16.v),
              onTap: () {
                onTapArrowLeft(context);
              }),
          actions: [
            AppbarTrailingImage(
                imagePath: ImageConstant.imgNotificationsTeal200,
                margin: EdgeInsets.symmetric(horizontal: 28.h, vertical: 14.v))
          ],
          styleType: Style.bgFill);
  }

  /// Section Widget
  Widget _buildEventList(BuildContext context, Organization organization) {
    return SizedBox(
        height: 40.v,
        child: ListView.separated(
            padding: EdgeInsets.only(left: 41.h, right: 51.h),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return SizedBox(width: 40.h);
            },
            itemCount: 1,
            itemBuilder: (context, index) {
              return Eventlist1ItemWidget(organization: organization);
            }));
  }

  /// Section Widget
  Widget _buildDetailCard(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        color: appTheme.gray300,
        shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(15)),
        child: Container(
            height: 57.v,
            width: 304.h,
            decoration: AppDecoration.fillGray300
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder28),
            child: Stack(alignment: Alignment.center, children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(8.h, 11.v, 35.h, 11.v),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.person,size: 35,),
                            Padding(
                                padding: EdgeInsets.only(left: 5.h),
                                child: _buildSixtyEight(context,
                                    lead: "Volunteer Lead ",
                                    name: organizationData.user!.name! +
                                        " " +
                                        organizationData.user!.surname!)),
                            Spacer(),
                            Padding(
                                padding:
                                EdgeInsets.only(top: 5.v, bottom: 13.v),
                                child: Text("Other activities",
                                    style: CustomTextStyles
                                        .bodySmallPrimaryContainer))
                          ]))),
            ])));
  }

  /// Section Widget
  // Widget _buildMap(BuildContext context) {
  //   return SizedBox(
  //       height: 250.v,
  //       width: double.maxFinite,
  //       child: GoogleMap(
  //           mapType: MapType.normal,
  //           initialCameraPosition: CameraPosition(
  //               target: LatLng(37.43296265331129, -122.08832357078792),
  //               zoom: 14.4746),
  //           onMapCreated: (GoogleMapController controller) {
  //             googleMapController.complete(controller);
  //           },
  //           zoomControlsEnabled: false,
  //           zoomGesturesEnabled: false,
  //           myLocationButtonEnabled: false,
  //           myLocationEnabled: false));
  // }

  /// Section Widget
  Widget _buildEventDetails(BuildContext context) {
    return Text("");
    // SizedBox(
    //     height: 252.v,
    //     width: double.maxFinite,
    //     child: Stack(alignment: Alignment.topCenter, children: [
    //       Align(
    //           alignment: Alignment.bottomCenter,
    //           child: Container(
    //               margin: EdgeInsets.fromLTRB(93.h, 209.v, 90.h, 5.v),
    //               padding:
    //                   EdgeInsets.symmetric(horizontal: 17.h, vertical: 6.v),
    //               decoration: AppDecoration.fillOnPrimary.copyWith(
    //                   borderRadius: BorderRadiusStyle.roundedBorder20),
    //               child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     CustomImageView(
    //                         imagePath: ImageConstant
    //                             .imgFluentarrowjoin20regularErrorcontainer,
    //                         height: 25.adaptSize,
    //                         width: 25.adaptSize,
    //                         margin: EdgeInsets.only(bottom: 1.v)),
    //                     Padding(
    //                         padding: EdgeInsets.only(left: 22.h, bottom: 4.v),
    //                         child: Text("Join the event",
    //                             style:
    //                                 CustomTextStyles.titleMediumErrorContainer))
    //                   ]))),
    //       Align(
    //           alignment: Alignment.topCenter,
    //           child: Padding(
    //               padding: EdgeInsets.symmetric(horizontal: 26.h),
    //               child: Column(mainAxisSize: MainAxisSize.min, children: [
    //                 Align(
    //                     alignment: Alignment.centerLeft,
    //                     child: Padding(
    //                         padding: EdgeInsets.only(left: 1.h),
    //                         child: Text("Participants",
    //                             style: CustomTextStyles.titleSmallBlack900))),
    //                 SizedBox(height: 3.v),
    //                 Divider(),
    //                 SizedBox(height: 12.v),
    //                 Padding(
    //                     padding: EdgeInsets.symmetric(horizontal: 36.h),
    //                     child: _buildParticipant2(context,
    //                         dynamicText: "1     ",
    //                         dynamicText1: "Oğuzhan Yavaş")),
    //                 SizedBox(height: 11.v),
    //                 Padding(
    //                     padding: EdgeInsets.symmetric(horizontal: 36.h),
    //                     child: _buildParticipant2(context,
    //                         dynamicText: "2     ",
    //                         dynamicText1: "Furkan Uzun")),
    //                 SizedBox(height: 11.v),
    //                 Padding(
    //                     padding: EdgeInsets.symmetric(horizontal: 36.h),
    //                     child: _buildParticipant2(context,
    //                         dynamicText: "3     ",
    //                         dynamicText1: "Ahmet Boztemur")),
    //                 SizedBox(height: 11.v),
    //                 Padding(
    //                     padding: EdgeInsets.symmetric(horizontal: 36.h),
    //                     child: _buildParticipant2(context,
    //                         dynamicText: "4     ",
    //                         dynamicText1: "Hasan Özgür Doğan")),
    //                 SizedBox(height: 11.v),
    //                 Padding(
    //                     padding: EdgeInsets.symmetric(horizontal: 36.h),
    //                     child: _buildParticipant2(context,
    //                         dynamicText: "5     ", dynamicText1: "Enes Silver"))
    //               ]))),
    //       Align(
    //           alignment: Alignment.bottomCenter,
    //           child: Container(
    //               height: 131.v,
    //               width: double.maxFinite,
    //               decoration: BoxDecoration(
    //                   color: appTheme.gray10001.withOpacity(0.7))))
    //     ]
    //     )
    // );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  /// Section Widget
  Widget _buildFloatingActionButton(BuildContext context) {
    return CustomFloatingButton(
        height: 50,
        width: 50,
        backgroundColor: appTheme.gray10001,
        child: CustomImageView(
            imagePath: ImageConstant.imgTablerLocation,
            height: 25.0.v,
            width: 25.0.h));
  }

  /// Common widget
  Widget _buildSixtyEight(
      BuildContext context, {
        required String lead,
        required String name,
      }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(lead,
          style: TextStyle(fontSize: 12,fontWeight: FontWeight.w200)
              .copyWith(color: theme.colorScheme.primary)),
      Text(name,
          style: TextStyle(fontSize: 10,fontWeight: FontWeight.w700)
              .copyWith(color: theme.colorScheme.primary))
    ]);
  }

  /// Common widget
  Widget _buildParticipant2(
      BuildContext context, {
        required String dynamicText,
        required String dynamicText1,
      }) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 3.v),
        decoration: AppDecoration.fillGray300
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          Text(dynamicText,
              style: theme.textTheme.labelMedium!
                  .copyWith(color: appTheme.black900)),
          Padding(
              padding: EdgeInsets.only(left: 34.h),
              child: Text(dynamicText1,
                  style: CustomTextStyles.bodySmallBlack900
                      .copyWith(color: appTheme.black900)))
        ]));
  }

  ///Handling route based on bottom click actions
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

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.mainPage:
        return MainPage();
      default:
        return DefaultWidget();
    }
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
