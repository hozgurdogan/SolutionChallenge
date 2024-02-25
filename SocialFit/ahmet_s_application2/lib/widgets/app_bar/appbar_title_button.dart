import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/presentation/login_screen/login_screen.dart';
import 'package:ahmet_s_application2/service/AuthService.dart';
import 'package:ahmet_s_application2/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import 'appbar_trailing_image.dart';

// ignore: must_be_immutable
class AppbarTitleButton extends StatelessWidget {
  AppbarTitleButton({
    Key? key,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Row(
          children: [
            AppbarTrailingImage(

              imagePath: ImageConstant.imgArrowLeft,
              onTap: (){

    Navigator.pop(context);




  },
              margin: EdgeInsets.symmetric(
                horizontal: 12.h,
                vertical: 14.v,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 55.h),
              child: CustomElevatedButton(
                height: 30.v,
                width: 100.h,
                text: "Settings",
                leftIcon: Container(
                  margin: EdgeInsets.only(right: 2.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      4.h,
                    ),
                  ),

                  child: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                ),
                buttonStyle: CustomButtonStyles.fillGrayLD,
                buttonTextStyle: CustomTextStyles.titleMediumGray10001,
              ),
            ),

            Spacer(),
            GestureDetector(
              onTap: (){

                bool control=AuthService().logOut();
                  if(control==true)
                    {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));
                    }
              },
              child: Text(
                "Log Out",
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
            Spacer(),

          ],
        ),
      ),
    );
  }
}
