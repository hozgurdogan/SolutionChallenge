import 'package:ahmet_s_application2/presentation/login_screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../core/utils/size_utils.dart';
import '../routes/app_routes.dart';
import '../theme/theme_helper.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Konum izni iste
  await _requestLocationPermission();

  // Firebase'in başlatılması
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDkYAqhhFqHPUIcrBj9HnRf-lFzLsulA7A",
      appId: "1:208194253130:android:e1bb81bf3fcf468eafd1b3",
      messagingSenderId: "208194253130",
      projectId: "solutionchallenge-9c1c8",
    ),
  );

  // Ekran yönünü ayarlama
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Uygulama başlatma
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
          home: SplashScreen(), // SplashScreen'dan başla
          routes: AppRoutes.routes,
        );
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 10), // 3 saniye sürecek
          () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()), // Ana sayfaya geç
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#FFFCF2"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Resim
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Image.asset('assets/images/AnagirisLogo.png'),
          ),

          // Boşluk
          SizedBox(height: 30),

          // Yükleniyor göstergesi
          Center(
            child: SpinKitCubeGrid(
              color: Colors.amber,
              size: 40.0,
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _requestLocationPermission() async {
  // Konum iznini kontrol etme
  var status = await Permission.location.status;

  // İzin durumuna göre işlem yapma
  switch (status) {
    case PermissionStatus.denied:
    // Kullanıcı izni reddetti
      await Permission.location.request();
      break;
    case PermissionStatus.granted:
    // Kullanıcı izni verdi
      break;
    case PermissionStatus.limited:
    // Kullanıcı izni sadece uygulama kullanılırken verildi
      break;
    case PermissionStatus.permanentlyDenied:
    // Kullanıcı izni kalıcı olarak reddedildi
      break;
  }
}
