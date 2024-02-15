import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/presentation/login_screen/login_screen.dart';
import 'package:ahmet_s_application2/service/AuthService.dart';
import 'package:ahmet_s_application2/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

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
            CustomElevatedButton(
              height: 30.v,
              width: 100.h,
              text: "Settings",
              leftIcon: Container(
                margin: EdgeInsets.only(right: 2.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    7.h,
                  ),
                ),
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
              buttonStyle: CustomButtonStyles.fillTeal,
              buttonTextStyle: CustomTextStyles.titleMediumGray10001,
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
                "Çıkış Yap",
                style: TextStyle(fontSize: 19, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
