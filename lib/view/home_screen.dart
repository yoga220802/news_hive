import 'package:flutter/material.dart';
import 'package:news_hive/utils/helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Text(
          'Welcome to the Home Screen!',
          style: poppinsStyle(
            fontSize: tsSubtitle2,
            fontWeight: fRegular,
            color: cBlack,
          ),
        ),
      ),
    );
  }
}
