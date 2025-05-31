import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:news_hive/controllers/news_controller.dart';
import 'package:news_hive/view/main_screen.dart';
import 'package:news_hive/view/news_detail_screen.dart';
import 'package:news_hive/view/splash_screen.dart';
import 'package:news_hive/utils/helper.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NewsController())],
      child: const MyApp(),
    ),
  );
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
          home: MainScreen(),
        );
      },
    );
  }
}
