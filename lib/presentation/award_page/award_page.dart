import 'package:ahmet_s_application2/service/OrganizationService.dart';

import '../../models/UserInfo.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../award_page/widgets/rankrow_item_widget.dart';
import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'package:ahmet_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:ahmet_s_application2/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

import '../profile_screen/profile.dart';


class AwardPage extends StatefulWidget {
  AwardPage();

  @override
  State<AwardPage> createState() => AwardPageState();
}



class AwardPageState extends State<AwardPage> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

List<InfoUser>sortedUsers=[];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      sortedUsers = await OrganizationService().getUsersSortedByScore();
      ;
      setState(() {

      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
            backgroundColor: appTheme.gray300,
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 27.h, vertical: 22.v),
                child: Column(children: [
                  Text("Winners of the Week",
                      style: theme.textTheme.headlineSmall),
                  SizedBox(height: 9.v),
                  Text("The next Top 5 begins soon",
                      style: theme.textTheme.labelMedium),
                  SizedBox(height: 2.v),
                  Text("5 Days", style: CustomTextStyles.bodyLargePrimary),
                  SizedBox(height: 27.v),
                   _buildWinnerCard(context),





                ])),
            bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 29.h, right: 26.h),
        child: _buildBottomBar(context))
      );

  }
Widget _buildBottomBar(BuildContext context) {
  return CustomBottomBar(onChanged: (BottomBarEnum type) {
    Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
  });
}


/// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 60.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 36.h, top: 16.v, bottom: 13.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgNotifications,
              margin: EdgeInsets.symmetric(horizontal: 43.h, vertical: 14.v))
        ],
        styleType: Style.bgFill);
  }

  /// Section Widget
Widget _buildWinnerCard(BuildContext context) {
  return Flexible(
    child: ListView.builder(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: sortedUsers?.length ?? 0,
      itemBuilder: (context, index) {
        final user = sortedUsers![index];

        return Container(
          width: 320.h,
          margin: EdgeInsets.only(right: 1.h),
          padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 9.v),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 17.h),
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 10),
             CustomImageView(
               imagePath: ImageConstant
                   .imgWhatsappGRsel87x84,
               height: 64.adaptSize,
               width: 64.adaptSize,
               radius: BorderRadius.circular(
                   36.h),
             ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.name} ${user.surname}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children:[
                      Icon(Icons.star,size: 25,),
                      Text(
                      user!.score.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
        ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );
}


  /// Section Widget
  Widget _buildRankRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 1.h),
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(height: 16.v);
            },
            itemCount: 4,
            itemBuilder: (context, index) {
              return RankrowItemWidget();
            }));
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
