import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_hive/view/splash_screen.dart';
import 'package:news_hive/utils/helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "News Hive",
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: cPrimary),
            useMaterial3: true,
          ),
          home: SplashScreen(), // Replace with your actual splash screen widget
        );
      },
    );
  }
}
