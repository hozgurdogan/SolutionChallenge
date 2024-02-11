import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import '../core/app_export.dart';
import 'dart:io';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
Future<void> main() async {




  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid ? await Firebase.initializeApp(
      options: const FirebaseOptions(apiKey: "AIzaSyDkYAqhhFqHPUIcrBj9HnRf-lFzLsulA7A",
          appId: "1:208194253130:android:e1bb81bf3fcf468eafd1b3",
          messagingSenderId: "208194253130",
          projectId: "solutionchallenge-9c1c8")

  ): await Firebase.initializeApp();





  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          title: 'ahmet_s_application2',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.loginScreen,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
