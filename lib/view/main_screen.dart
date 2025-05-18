import 'package:flutter/material.dart';
import 'package:news_hive/utils/helper.dart';
import 'package:news_hive/view/bookmark_screen.dart';
import 'package:news_hive/view/home_screen.dart';
import 'package:news_hive/view/profile_screen.dart';
import 'package:news_hive/widgets/app_bottom_navigation.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // List of screens to display
  final List<Widget> _screens = [
    const HomeScreen(),
    const BookmarkScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 36),
            hsTiny,
            Image.asset('assets/images/News Hive.png', height: 24),
          ],
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
