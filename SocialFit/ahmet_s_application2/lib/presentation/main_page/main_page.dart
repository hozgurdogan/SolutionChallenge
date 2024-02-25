import 'package:ahmet_s_application2/models/InfoUser.dart';
import 'package:ahmet_s_application2/presentation/map/searchmap.dart';
import 'package:ahmet_s_application2/service/AuthService.dart';
import 'package:ahmet_s_application2/service/OrganizationService.dart';
import 'package:ahmet_s_application2/service/UserService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../widgets/custom_bottom_bar.dart';
import '../createeventpage_page/createeventpage_page.dart';
import '../main_page/widgets/eventcard_item_widget.dart';
import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/widgets/custom_elevated_button.dart';
import 'package:ahmet_s_application2/widgets/custom_search_view.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../profile_screen/profile.dart';

// ignore_for_file: must_be_immutable
class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  TextEditingController searchController = TextEditingController();
  InfoUser userSession = InfoUser();
  String? _selectedFilter;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      InfoUser userData = await UserService().getCurrentUserInfo();
      setState(() {
        userSession = userData;
      });
    } catch (error) {
      print('Hata: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillWhite,
          child: Column(
            children: [
              _buildSeven(context),

              Container(
                color: HexColor("403D39"),
                height: 50.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(HexColor("FEBB02")), // Turuncu renk
                      ),
                      child: Container(
                        width: 120.h,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.filter_alt_rounded,
                              color: HexColor("FFFCF2"),
                            ),
                            Text(
                              "Newest to Oldest",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(HexColor("CCC5B9")), // Turuncu renk
                      ),
                      child: Container(
                        width: 120.h,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.filter_alt_rounded,

                              color: HexColor("FFFCF2"),
                            ),
                            Text(
                              "Oldest to Newest",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(HexColor("FEBB02")), // Eski renk
                      ),
                      child: Container(
                        width: 100.h,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.filter_alt_rounded,
                              color: HexColor("FFFCF2"),
                            ),
                            Text(
                              "Sort by score",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              RefreshIndicator(
                onRefresh: () async {
                  await OrganizationService().getAllOrganization();
                  setState(() {});
                },
                child: SizedBox(
                  height: 550.v,
                  width: double.maxFinite,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [_buildEventCard(context)],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 14.h, right: 11.h),
        child: _buildBottomBar(context),
      ),
    );
  }

  Widget _buildSeven(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 36.h,
        vertical: 30.v,
      ),
      decoration: AppDecoration.fillBrownD,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 1.v, top: 25.v),
            child: userSession.name != null && userSession.surname != null
                ? Column(
                    children: [
                      Text(
                        "Welcome SociaFit",
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                      Text(
                        "${userSession.name} ${userSession.surname}",
                        style: TextStyle(fontSize: 12, color: Colors.white,fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                : CircularProgressIndicator(),
          ),
          _buildCreateButton(context),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.only(top: 30, left: 13),
              child: Icon(Icons.notifications, size: 20, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEventCard(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 9.h,
          vertical: 5.v,
        ),
        decoration: AppDecoration.outlineDeepPurpleA.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder5,
        ),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(height: 14.v),
          itemCount: 1,
          itemBuilder: (context, index) => EventcardItemWidget(),
        ),
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

  Widget _buildCreateButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CreateEventPage()),
        );
      },
      height: 29.v,
      width: 90.h,
      text: "Create",
      margin: EdgeInsets.only(left: 17.h, bottom: 1.v, top: 25.v),
      leftIcon: Container(
        margin: EdgeInsets.only(right: 5.h),
        child: Icon(Icons.add_circle, size:15,color: HexColor("CCC5B9")),
      ),
      buttonStyle: CustomButtonStyles.fillOnPrimary,
      buttonTextStyle: TextStyle(fontSize: 16, color: HexColor("CCC5B9")),
    );
  }
}
