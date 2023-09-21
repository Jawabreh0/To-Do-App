import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/presentation/features/home/screen/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomeScreen(),
        //body: CategoriesPage(),
      ),
    );
  }
}
