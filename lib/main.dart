import 'package:flutter/material.dart';
import 'package:yellow_exchange/pages/login.dart';
import 'package:yellow_exchange/pages/splash.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: ThemeData(),
        routes: {
          "/login" : (context) => const Login(),
        }
      )
  );

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((_) {
  //
  // });
}