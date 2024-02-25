import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/models/InfoUser.dart';
import 'package:ahmet_s_application2/presentation/map/locationMap.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../service/OrganizationService.dart';
import '../../service/UserService.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../profile_screen/profile.dart';

class JoinedActivitiesScreen extends StatelessWidget {
  final String id;
  final int score;
  final String title;
  final String description;
  final String city;
  final String town;
  final dynamic user;
  final DateTime startDate;
  final DateTime endDate;
  final double? latitude;
  final double? longitude;

  JoinedActivitiesScreen({
    required this.id,
    required this.score,
    required this.title,
    required this.description,
    required this.city,
    required this.town,
    required this.user,
    required this.startDate,
    required this.endDate,
    this.latitude,
    this.longitude,
  });

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 54.h,
        leading: AppbarLeadingImage(
          imagePath: ImageConstant.imgArrowLeft,
          margin: EdgeInsets.only(left: 30.h, top: 13.v, bottom: 16.v),
          onTap: () {
            Navigator.pop(context); // Geri tuşuna basıldığında önceki sayfaya dön
          },
        ),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgNotifications,
              margin: EdgeInsets.symmetric(horizontal: 28.h, vertical: 14.v)
          )
        ],
        styleType: Style.bgFill
    );
  }

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    String latituderAsString = latitude.toString();
    String longitudeAsString = longitude.toString();

    final dateFormat = DateFormat('dd.MM.yyyy');
    final timeFormat = DateFormat('HH:mm');

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      OrganizationService().joinOrganization(id);
    });

    final userService = UserService();
    final userInfoFuture = userService.getUserInfoByEmail();


    return Scaffold(
      appBar: _buildAppBar(context),
      body:FutureBuilder(
        future: userInfoFuture,
        builder: (context, AsyncSnapshot<InfoUser> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            final userInfo = snapshot.data;


            return Center(
              child: SingleChildScrollView(
                child: Card(
                  margin: EdgeInsets.all(20),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 100,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Activity joined successfully!',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Activity Name:',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          title,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Description:',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          description,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'City:',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          city,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Town:',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          town,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Start Date:',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${dateFormat.format(startDate)} ${timeFormat.format(startDate)}',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'End Date:',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${dateFormat.format(endDate)} ${timeFormat.format(endDate)}',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Name:',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          userInfo?.name ?? '',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Surname:',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          userInfo?.surname ?? '',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.pop(context);
                            //   },
                            //   style: ElevatedButton.styleFrom(
                            //     primary: appTheme.teal200,
                            //     elevation: 3,
                            //     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(10),
                            //     ),
                            //     textStyle: TextStyle(
                            //       fontSize: 15,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            //   child: Text('Back to Home',style: TextStyle(color: Colors.white),),
                            // ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                print("LAN"+latitude.toString());
                                print("LAN"+longitude.toString());

                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapScreen(x: latitude!, y: longitude!),));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: appTheme.orange,
                                elevation: 3,
                                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: Text('Go Location',style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ),
                      ],
                    ),
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
      ),    );

  }
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }
}