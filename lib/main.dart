import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/core/constants/palette.dart';
import 'package:todo/dependency_injection/injection.dart';
import 'package:todo/presentation/login/screen/login_screen.dart';

void main() {
  DependencyInjection.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: appColor,
        fontFamily: 'Lato',
      ),
      home: Scaffold(
        body: LoginScreen(),
      ),
    ),
  );
}
