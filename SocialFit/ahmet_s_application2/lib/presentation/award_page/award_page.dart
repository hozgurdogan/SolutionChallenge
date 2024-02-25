import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/service/OrganizationService.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../core/utils/image_constant.dart';
import '../../models/InfoUser.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_image_view.dart';
import '../profile_screen/profile.dart';

class AwardPage extends StatefulWidget {
  AwardPage();

  @override
  State<AwardPage> createState() => AwardPageState();
}

class AwardPageState extends State<AwardPage> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  List<InfoUser> sortedUsers = [];

  @override
  void initState() {
    super.initState();
    _fetchSortedUsers();
  }

  Future<void> _fetchSortedUsers() async {
    sortedUsers = await OrganizationService().getUsersSortedByScore();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("FFFCF2"),
      appBar: _buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 27.0, vertical: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Padding(
            //   padding: EdgeInsets.only(top: 50.h),
            //   child: Container(
            //     // change your height based on preference
            //     height: 120.h,
            //     width: double.infinity,
            //     child: ListView(
            //       // set the scroll direction to horizontal
            //       scrollDirection: Axis.horizontal,
            //       children: <Widget>[
            //         Card(
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10), // Kenarları yuvarlama
            //           ),
            //           child: Container(
            //             height: 30,
            //             width: 120,
            //             decoration: BoxDecoration(
            //               gradient: LinearGradient(
            //                 colors: [
            //                   Colors.yellow,
            //                   Colors.orangeAccent,
            //                   Colors.yellow.shade300,
            //                 ],
            //                 begin: Alignment.topLeft,
            //                 end: Alignment.bottomRight,
            //               ),
            //               borderRadius: BorderRadius.circular(10), // Kenarları yuvarlama
            //             ),
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Icon(
            //                   Icons.directions_bike_outlined,
            //                   size: 80,
            //                   color: Colors.white,
            //                 ),
            //                 Text(
            //                   "Bicycle",
            //                   style: TextStyle(
            //                       fontSize: 20, fontWeight: FontWeight.bold),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //         // add your widgets here// space them using a sized box
            //         SizedBox(
            //           width: 15,
            //         ),
            //         Card(
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10), // Kenarları yuvarlama
            //           ),
            //           child: Container(
            //             height: 30,
            //             width: 120,
            //             decoration: BoxDecoration(
            //               gradient: LinearGradient(
            //                 colors: [
            //                   Colors.yellow,
            //                   Colors.orangeAccent,
            //                   Colors.yellow.shade300,
            //                 ],
            //                 begin: Alignment.topLeft,
            //                 end: Alignment.bottomRight,
            //               ),
            //               borderRadius: BorderRadius.circular(10), // Kenarları yuvarlama
            //             ),
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Icon(
            //                   Icons.directions_bike_outlined,
            //                   size: 80,
            //                   color: Colors.white,
            //                 ),
            //                 Text(
            //                   "Bisiklet",
            //                   style: TextStyle(
            //                       fontSize: 20, fontWeight: FontWeight.bold),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //         SizedBox(
            //           width: 15,
            //         ),
            //         Card(
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10), // Kenarları yuvarlama
            //           ),
            //           child: Container(
            //             height: 30,
            //             width: 120,
            //             decoration: BoxDecoration(
            //               gradient: LinearGradient(
            //                 colors: [
            //                   Colors.yellow,
            //                   Colors.orangeAccent,
            //                   Colors.yellow.shade300,
            //                 ],
            //                 begin: Alignment.topLeft,
            //                 end: Alignment.bottomRight,
            //               ),
            //               borderRadius: BorderRadius.circular(10), // Kenarları yuvarlama
            //             ),
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Icon(
            //                   Icons.directions_bike_outlined,
            //                   size: 80,
            //                   color: Colors.white,
            //                 ),
            //                 Text(
            //                   "Bisiklet",
            //                   style: TextStyle(
            //                       fontSize: 20, fontWeight: FontWeight.bold),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Text(
              "Winners of the Week",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),

            Text(
              "5 Days",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Expanded(child: _buildWinnerList(context)),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 29.0, right: 26.0),
        child: _buildBottomBar(context),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, getCurrentRoute(type));
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 60.0,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 36.0, top: 16.0, bottom: 13.0),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgNotifications,
          margin: EdgeInsets.symmetric(horizontal: 43.0, vertical: 14.0),
        ),
      ],
      styleType: Style.bgFill,
    );
  }

  Widget _buildWinnerList(BuildContext context) {
    return ListView.builder(
      itemCount: sortedUsers.length,
      itemBuilder: (context, index) {
        final user = sortedUsers[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: _buildWinnerCard(user, index),
        );
      },
    );
  }
  Widget _buildWinnerCard(InfoUser user, int index) {
    if (index == 0 || index == 1 || index == 2) {
      // Ödül kartlarını oluştur
      String awardText;
      Color cardColor;
      IconData icon;
      String iconText;
      if (index == 0) {
        awardText = '1st Award';
        cardColor = Colors.green;
        icon = Icons.directions_bike;
        iconText = 'Bicycle';
      } else if (index == 1) {
        awardText = '2nd Award';
        cardColor = Colors.blue;
        icon = Icons.electric_scooter;
        iconText = 'Scooter';
      } else {
        awardText = '3rd Award';
        cardColor = Colors.orange;
        icon = Icons.roller_skating;
        iconText = 'Skate';
      }

      return Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user.name} ${user.surname}',
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: 5.0),
                        CustomImageView(
                          imagePath: user.getProfilePicturePath(),
                          height: 64.0,
                          width: 64.0,
                          radius: BorderRadius.circular(32.0),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: [
                            Icon(Icons.star, size: 25.0, color: Colors.white),
                            SizedBox(width: 5.0),
                            Text(
                              user.score.toString(),
                              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          awardText,
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: 5.0),
                        Icon(icon, size: 50, color: Colors.white), // Ödül ikonu
                        SizedBox(height: 5.0),
                        Text(
                          iconText,
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      // Diğer kartları oluştur
      return Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: HexColor("CCC5B9"),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${user.name} ${user.surname}',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 5.0),
                  CustomImageView(
                    imagePath: user.getProfilePicturePath(),
                    height: 64.0,
                    width: 64.0,
                    radius: BorderRadius.circular(32.0),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, size: 25.0, color: Colors.black),
                      SizedBox(width: 5.0),
                      Text(
                        user.score.toString(),
                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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

  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
