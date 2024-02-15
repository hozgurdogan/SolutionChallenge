import 'package:flutter/material.dart';
import 'package:ahmet_s_application2/presentation/login_screen/login_screen.dart';
import 'package:ahmet_s_application2/presentation/main_container_screen/main_container_screen.dart';
import 'package:ahmet_s_application2/presentation/detailstwo_screen/detailstwo_screen.dart';
import 'package:ahmet_s_application2/presentation/profile_screen/profile_screen.dart';
import 'package:ahmet_s_application2/presentation/award_screen/award_screen.dart';
import 'package:ahmet_s_application2/presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String loginScreen = '/login_screen';

  static const String mainPage = '/main_page';

  static const String createAccountScreen = '/create_account_screen'; // Define route for Create Account screen


  static const String mainContainerScreen = '/main_container_screen';

  static const String detailstwoScreen = '/detailstwo_screen';

  static const String profileScreen = '/profile_screen';

  static const String awardScreen = '/award_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => LoginScreen(),
    mainContainerScreen: (context) => MainContainerScreen(),
    detailstwoScreen: (context) => DetailstwoScreen( organizationID: '',),
    profileScreen: (context) => ProfileScreen(),
    awardScreen: (context) => AwardScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}
