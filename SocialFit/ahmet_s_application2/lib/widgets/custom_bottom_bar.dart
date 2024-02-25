import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/presentation/award_page/award_page.dart';
import 'package:ahmet_s_application2/presentation/main_page/main_page.dart';
import 'package:ahmet_s_application2/presentation/profile_screen/profile.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgNavHome,
      activeIcon: ImageConstant.imgNavHome,
      title: "Home",
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavScore,
      activeIcon: ImageConstant.imgNavScore,
      title: "Score",
      type: BottomBarEnum.Score,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavProfile,
      activeIcon: ImageConstant.imgNavProfile,
      title: "Profile",
      type: BottomBarEnum.Profile,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color: HexColor("#252422"),
          borderRadius: BorderRadius.circular(37),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0,
          elevation: 0,
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          items: List.generate(bottomMenuList.length, (index) {
            return BottomNavigationBarItem(
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: bottomMenuList[index].icon,
                    height: 35,
                    width: 35,
                    color: HexColor("#FFFCF2"),
                  ),
                  Text(
                    bottomMenuList[index].title ?? "",
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              activeIcon: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: bottomMenuList[index].activeIcon,
                    height: 35,
                    width: 35,
                    color: HexColor("#FFFCF2"),
                  ),
                  Text(
                    bottomMenuList[index].title ?? "",
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: HexColor("#FFFCF2"),
                    ),
                  ),
                ],
              ),
              label: '',
            );
          }),
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
            if (selectedIndex == 0) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MainPage()),
              );
            } else if (selectedIndex == 1) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AwardPage()),
              );
            } else if (selectedIndex == 2) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            }
          },
        ),
      ),
    );
  }
}

enum BottomBarEnum {
  Home,
  Score,
  Profile,
  AllLocation,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
  });

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;
}


class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }}