import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/presentation/create_account_screen/create_account_screen.dart';
import 'package:ahmet_s_application2/service/AuthService.dart';
import 'package:ahmet_s_application2/widgets/custom_elevated_button.dart';
import 'package:ahmet_s_application2/widgets/custom_icon_button.dart';
import 'package:ahmet_s_application2/widgets/custom_text_form_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../create_account_screen/register.dart';
import '../main_page/main_page.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key})
      : super(
    key: key,
  );

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#FFFCF2"),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // Klavyeyi gizle
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 32.h),
                child: Column(
                  children: [
                    SizedBox(
                      height: 407.v,
                      width: 309.h,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.socia,
                            height: 110.v,
                            width: 250.h,
                            alignment: Alignment.topCenter,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 50.h),
                            child: CustomImageView(
                              imagePath: "assets/images/logi.png",
                              height: 200.adaptSize,
                              width: 400.adaptSize,
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 5.h,
                        right: 6.h,
                      ),
                      child: CustomTextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "The email is not be empty";
                          } else if (EmailValidator.validate(value) ==
                              false) {
                            return "Please enter a valid email";
                          }
                        },
                        controller: emailController,
                        hintText: "Email",
                        textInputType:
                        TextInputType.text, // TextInputType.text olarak ayarlandı
                        prefix: Container(
                            margin: EdgeInsets.fromLTRB(20.h, 10.v, 18.h, 10.v),
                            child: Icon(
                              Icons.email,
                              size: 25,
                              color: Colors.white,
                            )),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 50.v,
                        ),
                        cursorColor: Colors.white, // İmleci beyaz yapar
                      ),
                    ),
                    SizedBox(height: 12.v),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 5.h,
                        right: 6.h,
                      ),
                      child: CustomTextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "The password is not be empty";
                          }
                        },
                        controller: passwordController,
                        hintText: "Password",
                        textInputType:
                        TextInputType.text, // TextInputType.text olarak ayarlandı
                        textInputAction: TextInputAction.done,
                        prefix: Container(
                            margin: EdgeInsets.fromLTRB(16.h, 9.v, 18.h, 11.v),
                            child: Icon(
                              Icons.password,
                              color: Colors.white,
                              size: 25,
                            )),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 50.v,
                        ),
                        cursorColor: Colors.white, // İmleci beyaz yapar
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height: 14.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 5.h,
                          right: 24.h,
                        ),
                      ),
                    ),
                    SizedBox(height: 26.v),
                    CustomElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AuthService().login(
                              context: context,
                              email: emailController.text,
                              password: passwordController.text);
                        }
                      },
                      text: "Sign In",
                      margin: EdgeInsets.only(
                        left: 27.h,
                        right: 29.h,
                      ),
                      leftIcon: Container(
                          margin: EdgeInsets.only(right: 20.h),
                          child: Icon(
                            Icons.login,
                            size: 35,
                            color: Colors.black,
                          )),
                      buttonStyle: CustomButtonStyles.fillOnPrimary,
                    ),
                    SizedBox(height: 10.v),
                    Divider(
                      color: theme.colorScheme.onErrorContainer,
                      indent: 21.h,
                      endIndent: 12.h,
                    ),
                    SizedBox(height: 15.v),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconButton(
                          onTap: () {
                            AuthService().signInWithGoogle(context);
                          },
                          height: 50.adaptSize,
                          width: 50.adaptSize,
                          padding: EdgeInsets.all(9.h),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgGoogle,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 7.h),
                            child: Text(
                              "Sign with Google ",
                              style: TextStyle(fontSize: 15),
                            )),
                      ],
                    ),
                    SizedBox(height: 25.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.v),
                            child: Text(
                              "Don’t have an account?",
                              style: CustomTextStyles.bodyLargePrimary_1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 14.h),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      RegisterresponsiveScreen(),
                                ));
                              },
                              child: Text(
                                "Sign Up",
                                style: CustomTextStyles.bodyLargePrimary.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.v),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
