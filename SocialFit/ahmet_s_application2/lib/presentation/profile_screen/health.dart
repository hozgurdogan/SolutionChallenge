import 'package:ahmet_s_application2/models/InfoUser.dart';
import 'package:ahmet_s_application2/models/Organization.dart';
import 'package:ahmet_s_application2/presentation/profile_screen/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:pedometer/pedometer.dart';

import '../../core/utils/image_constant.dart';
import '../../service/UserService.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}


class Heal extends StatefulWidget {
  final Organization organization;

  Heal({required this.organization});

  @override
  _HealState createState() => _HealState();
}




class _HealState extends State<Heal> {

  InfoUser user = InfoUser();
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?';
  int _steps = 0;
  int _previousSteps = 0;
  int _incrementalSteps = 0;
  int _totalSteps = 0;
  bool _isLoading = true; // Yükleme durumu
  @override
  void initState() {
    super.initState();
    UserService().getCurrentUserInfo().then((userInfo) {
      setState(() {
        user = userInfo;
        _isLoading = false;
      });
    });
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    setState(() {
      _totalSteps = event.steps;
      _incrementalSteps = _incrementalSteps + _totalSteps - _previousSteps;
      _previousSteps = _totalSteps;
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    setState(() {
      _status = 'Pedestrian Status not available';
    });
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream.listen(onPedestrianStatusChanged).onError(
        onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {},
    );
  }

  Widget _buildStatContainer(String title, String count, Color color) {
    return Container(
      width: 120,
      height: 120,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: HexColor("EB5E28"), width: 3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            count,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityInfo(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title + ':',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _onStartButtonPressed() {
    setState(() {
      _previousSteps = 0;
      _incrementalSteps = 0;
      _totalSteps = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Yükleniyor durumu
          : SingleChildScrollView(
            child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profil bilgileri card'ı
              Card(
                color: HexColor("FFFCF2"),
                elevation: 5,
                margin: EdgeInsets.all(20),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Profil resmi
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          user != null
                              ? user.getProfilePicturePath()
                              : 'assets/default_profile.jpg',
                        ),
                      ),
                      SizedBox(height: 10),
                      // İsim Soyisim
                      Text(
                        user.name! + " " + user.surname!,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // İstatistikler
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Adım sayısı
                  _buildStatContainer(
                    'Step',
                    _incrementalSteps.toString(),
                    HexColor("CCC5B9"),
                  ),
                  // KM
                  _buildStatContainer(
                    'Km',
                    (_incrementalSteps.toDouble() / 1000).toString(),
                    HexColor("CCC5B9"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Etkinlik detayları card'ı
              Card(
                color: HexColor("CCC5B9"),
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Activity Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Etkinlik bilgileri
                      _buildActivityInfo(
                        'Activity Title',
                        widget.organization.title!,
                      ),
                      _buildActivityInfo(
                        'Score',
                        widget.organization.score.toString(),
                      ),
                      _buildActivityInfo(
                        'City',
                        widget.organization.city!,
                      ),
                      _buildActivityInfo(
                        'Date',
                        DateFormat.yMMMM().format(
                          widget.organization.startDate!,
                        ),
                      ),
                      _buildActivityInfo(
                        'Time',
                        DateFormat.Hm().format(
                          widget.organization.startDate!,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Start Analyze butonu
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: HexColor("EB5E28"),
                ),
                onPressed: () {
                  _onStartButtonPressed();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 14, right: 15),
                  child: Text(
                    "Start Analyze",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Pedestrian durumu
            ],
        ),
      ),
          ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }
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
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
