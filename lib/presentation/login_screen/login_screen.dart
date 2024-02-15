import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/presentation/create_account_screen/create_account_screen.dart';
import 'package:ahmet_s_application2/service/AuthService.dart';
import 'package:ahmet_s_application2/widgets/custom_elevated_button.dart';
import 'package:ahmet_s_application2/widgets/custom_icon_button.dart';
import 'package:ahmet_s_application2/widgets/custom_text_form_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: appTheme.teal200,
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: SizeUtils.width,
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
                            imagePath: ImageConstant.imgLogo,
                            height: 139.v,
                            width: 232.h,
                            alignment: Alignment.topCenter,
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgMaskGroup,
                            height: 309.adaptSize,
                            width: 309.adaptSize,
                            alignment: Alignment.bottomCenter,
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
                          } else if (EmailValidator.validate(value) == false) {
                            return "Please enter a valid email";
                          }
                        },
                        controller: emailController,
                        hintText: "Email",
                        textInputType: TextInputType.emailAddress,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(20.h, 10.v, 18.h, 10.v),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgSolaruserbroken,
                            height: 30.adaptSize,
                            width: 30.adaptSize,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 50.v,
                        ),
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
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.visiblePassword,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(16.h, 9.v, 18.h, 11.v),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgSolarlockpasswordbroken,
                            height: 30.adaptSize,
                            width: 30.adaptSize,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 50.v,
                        ),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomIconButton(
                              height: 30.adaptSize,
                              width: 30.adaptSize,
                              padding: EdgeInsets.all(3.h),
                              decoration: IconButtonStyleHelper.fillPrimary,
                              child: CustomImageView(
                                imagePath:
                                ImageConstant.imgMaterialSymbolsLightCheck,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 5.v,
                                bottom: 4.v,
                              ),
                              child: Text(
                                "Forget your password?",
                                style: CustomTextStyles.bodyLargePrimary_1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 26.v),
                    CustomElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate())
                        {
                          AuthService().login(context: context, email: emailController.text, password: passwordController.text);

                        }
                      },
                      text: "Sign In",
                      margin: EdgeInsets.only(
                        left: 32.h,
                        right: 29.h,
                      ),
                      leftIcon: Container(
                        margin: EdgeInsets.only(right: 30.h),
                        child: CustomImageView(
                          imagePath: ImageConstant
                              .imgMaterialsymbolslightloginoutlinerounded,
                          height: 29.adaptSize,
                          width: 29.adaptSize,
                        ),
                      ),
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
                          height: 50.adaptSize,
                          width: 50.adaptSize,
                          padding: EdgeInsets.all(9.h),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgFlatColorIconsGoogle,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 24.h),
                          child: CustomIconButton(
                            height: 50.adaptSize,
                            width: 50.adaptSize,
                            padding: EdgeInsets.all(10.h),
                            child: CustomImageView(
                              imagePath: ImageConstant.imgLogosFacebook,
                            ),
                          ),
                        ),
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
                                // "Sign Up" yazısına tıklandığında belirtilen sayfaya yönlendirilir
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateAccountScreen(),));
                              },
                              child: Text(
                                "Sign Up",
                                style: CustomTextStyles.bodyLargePrimary.copyWith(
                                  decoration: TextDecoration.underline, // Metni altı çizili yapar
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
