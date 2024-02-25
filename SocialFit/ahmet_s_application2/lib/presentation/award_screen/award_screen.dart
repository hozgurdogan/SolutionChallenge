import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/presentation/main_page/main_page.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'package:ahmet_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:ahmet_s_application2/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

class AwardScreen extends StatelessWidget {
  AwardScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray100,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Text(
              "Top Performers",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            _buildTopPerformer(context, "1", "Oğuzhan Yavaş"),
            _buildTopPerformer(context, "2", "Furkan Uzun"),
            _buildTopPerformer(context, "3", "Ahmet Boztemur"),
            _buildTopPerformer(context, "4", "Hasan Özgür Doğan"),
            _buildTopPerformer(context, "5", "Enes Silver"),
            SizedBox(height: 40.0),
            Text(
              "Winner of the Week",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            _buildWinnerOfTheWeek(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        onTap: () => Navigator.pop(context),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgNotificationsTeal200,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
          navigatorKey.currentContext!,
          getCurrentRoute(type),
        );
      },
    );
  }

  Widget _buildTopPerformer(
      BuildContext context,
      String dynamicText,
      String dynamicText1,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Text(
            dynamicText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(width: 20.0),
          Text(dynamicText1),
        ],
      ),
    );
  }

  Widget _buildWinnerOfTheWeek(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2.0),
            ),
            child: CircleAvatar(
              radius: 40.0,
              backgroundImage: AssetImage(ImageConstant.imageNotFound),
            ),
          ),
          SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "furkanuzunz",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 5.0),
              Text("Member since January 2022"),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 5.0),
                  Text(
                    "75",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
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
}
