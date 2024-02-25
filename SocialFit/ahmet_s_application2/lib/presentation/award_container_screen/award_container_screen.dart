import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/presentation/award_page/award_page.dart';
import 'package:ahmet_s_application2/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../widgets/custom_bottom_bar.dart';

// ignore_for_file: must_be_immutable
class AwardContainerScreen extends StatelessWidget {
  AwardContainerScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.gray300,
            body: Navigator(
                key: navigatorKey,
                initialRoute: AppRoutes.awardPage,
                onGenerateRoute: (routeSetting) => PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) =>
                        getCurrentPage(routeSetting.name!),
                    transitionDuration: Duration(seconds: 0))),
            bottomNavigationBar: Padding(
                padding: EdgeInsets.only(left: 29.h, right: 26.h),
                child: _buildBottomBar(context))));
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.awardPage;
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
      case AppRoutes.awardPage:
        return AwardPage();
      default:
        return DefaultWidget();
    }
  }
}
