import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/presentation/main_page/main_page.dart';
import 'package:ahmet_s_application2/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

class MainContainerScreen extends StatelessWidget {
  MainContainerScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.mainPage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!),
            transitionDuration: Duration(seconds: 0),
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    // Eğer mevcut bir bottom bar varsa tekrar oluşturma
    if (ModalRoute.of(context)!.isFirst) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.h),
        child: CustomBottomBar(onChanged: (BottomBarEnum type) {
          Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
        }),
      );
    } else {
      return SizedBox.shrink(); // Mevcut bir bottom bar varsa boş bir widget döndür
    }
  }

  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.mainPage;
      case BottomBarEnum.Score:
      case BottomBarEnum.Profile:
      case BottomBarEnum.AllLocation:
      default:
        return "/";
    }
  }

  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.mainPage:
        return MainPage();
      default:
        return DefaultWidget();
    }
  }
}
