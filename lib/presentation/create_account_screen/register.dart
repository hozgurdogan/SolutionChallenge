import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/presentation/login_screen/login_screen.dart';
import 'package:ahmet_s_application2/service/AuthService.dart';
import 'package:ahmet_s_application2/widgets/custom_elevated_button.dart';
import 'package:ahmet_s_application2/widgets/custom_icon_button.dart';
import 'package:ahmet_s_application2/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class RegisterresponsiveScreen extends StatelessWidget {
  RegisterresponsiveScreen({Key? key})
      : super(
    key: key,
  );

  TextEditingController nameEditTextController = TextEditingController();

  TextEditingController surnameEditTextController = TextEditingController();

  TextEditingController userNameEditTextController = TextEditingController();

  TextEditingController emailEditTextController = TextEditingController();

  TextEditingController passwordEditTextController = TextEditingController();

  TextEditingController confirmpasswordEditTextController =
  TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> register(BuildContext context) async {
    final String name = nameEditTextController.text.trim();
    final String surname = surnameEditTextController.text.trim();
    final String username = userNameEditTextController.text.trim();
    final String email = emailEditTextController.text.trim();
    final String password = passwordEditTextController.text;
    final String passwordConfirm = confirmpasswordEditTextController.text;

    AuthService().register(
      context: context,
      name: name,
      surname: surname,
      username: username,
      email: email,
      password: password,
      passwordConfirm: passwordConfirm,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:appTheme.teal200,
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
                padding: EdgeInsets.symmetric(
                  horizontal: 26.h,
                  vertical: 17.v,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 11.v),
                    CustomImageView(
                      imagePath: ImageConstant.imgSolaruserbroken,
                      height: 100.v,
                      width: 240.h,
                    ),
                    SizedBox(height: 2.v),
                    Align(
                      alignment: Alignment.center,


                        child: Text(
                          "Register",
                          style: TextStyle(fontSize: 40),
                        ),
                    ),
                    SizedBox(height: 24.v),
                    Divider(),
                    SizedBox(height: 24.v),
                    _buildNameEditText(context),
                    SizedBox(height: 21.v),
                    _buildSurnameEditText(context),
                    SizedBox(height: 21.v),
                    _buildUserNameEditText(context),
                    SizedBox(height: 21.v),
                    _buildEmailEditText(context),
                    SizedBox(height: 21.v),
                    _buildPasswordEditText(context),
                    SizedBox(height: 21.v),
                    _buildConfirmpasswordEditText(context),
                    SizedBox(height: 21.v),
                    Divider(),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 3.h,
                          right: 69.h,
                        ),
                        child: Row(
                          children: [


                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.v),

                    SizedBox(height: 10.v),
                    _buildSignUpButton(context),
                    SizedBox(height: 10.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 34.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Do you have any account?",
                            style: TextStyle(fontSize: 15),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 3.h),
                            child: TextButton(
                              onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),)); },
                              child: Text("Login",style: TextStyle(fontSize: 20),),
                        
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildNameEditText(BuildContext context) {
    return CustomTextFormField(
      controller: nameEditTextController,
      textInputType: TextInputType.phone,
      hintText: "Name",
      prefix: Container(
        margin: EdgeInsets.fromLTRB(29.h, 8.v, 15.h, 8.v),
        child: Icon(
         Icons.edit,size: 25,color: Colors.white,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 47.v,
      ),
      contentPadding: EdgeInsets.only(
        top: 15.v,
        right: 30.h,
        bottom: 15.v,
      ),
      borderDecoration: UnderlineInputBorder(),
      fillColor: HexColor("#232121"),
    );
  }

  /// Section Widget
  Widget _buildSurnameEditText(BuildContext context) {
    return CustomTextFormField(
      fillColor: HexColor("#232121"),

      controller: surnameEditTextController,
      hintText: "Surname",
      prefix: Container(
        margin: EdgeInsets.fromLTRB(29.h, 8.v, 15.h, 8.v),
        child: Icon(
          Icons.edit,size: 25,color: Colors.white,
        ),

      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 47.v,
      ),
      contentPadding: EdgeInsets.only(
        top: 15.v,
        right: 30.h,
        bottom: 15.v,
      ),
      borderDecoration: UnderlineInputBorder(),
    );
  }

  /// Section Widget
  Widget _buildUserNameEditText(BuildContext context) {
    return CustomTextFormField(
      controller: userNameEditTextController,
      hintText: "Username",
      prefix: Container(
        margin: EdgeInsets.fromLTRB(29.h, 8.v, 15.h, 8.v),
        child: Icon(
          Icons.person,size: 25,color: Colors.white,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 47.v,
      ),
      contentPadding: EdgeInsets.only(
        top: 15.v,
        right: 30.h,
        bottom: 15.v,
      ),
      borderDecoration: UnderlineInputBorder(),
      fillColor: HexColor("#232121"),
    );
  }

  /// Section Widget
  Widget _buildEmailEditText(BuildContext context) {
    return CustomTextFormField(
      controller: emailEditTextController,
      hintText: "Email",
      textInputType: TextInputType.emailAddress,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(29.h, 8.v, 15.h, 8.v),
        child: Icon(
          Icons.mail,size: 25,color: Colors.white,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 47.v,
      ),
      contentPadding: EdgeInsets.only(
        top: 15.v,
        right: 30.h,
        bottom: 15.v,
      ),
      borderDecoration: UnderlineInputBorder(),
      fillColor: HexColor("#232121"),
    );
  }

  /// Section Widget
  Widget _buildPasswordEditText(BuildContext context) {
    return CustomTextFormField(
      controller: passwordEditTextController,
      hintText: "Password",
      textInputType: TextInputType.visiblePassword,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(29.h, 8.v, 15.h, 8.v),
        child: Icon(
          Icons.password,size: 25,color: Colors.white,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 47.v,
      ),
      obscureText: true,
      contentPadding: EdgeInsets.only(
        top: 15.v,
        right: 30.h,
        bottom: 15.v,
      ),
      borderDecoration: UnderlineInputBorder(),
      fillColor: HexColor("#232121"),
    );
  }

  /// Section Widget
  Widget _buildConfirmpasswordEditText(BuildContext context) {
    return CustomTextFormField(
      controller: confirmpasswordEditTextController,
      hintText: "Confirm Password",
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.visiblePassword,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(29.h, 8.v, 15.h, 8.v),
        child: Icon(
          Icons.password,size: 25,color: Colors.white,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 47.v,
      ),
      obscureText: true,
      contentPadding: EdgeInsets.only(
        top: 15.v,
        right: 30.h,
        bottom: 15.v,
      ),
      borderDecoration: UnderlineInputBorder(),
      fillColor: HexColor("#232121"),
    );
  }

  /// Section Widget
  Widget _buildSignUpButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () => register(context),
      width: 144.h,
      text: "Sign Up",
      leftIcon: Container(
        child: Icon(Icons.app_registration,size: 30,color: Colors.black,)
      ),
    );
  }
}
