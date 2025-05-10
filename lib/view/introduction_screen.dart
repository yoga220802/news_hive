import 'package:flutter/material.dart';
import 'package:news_hive/view/utils/helper.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  List<Map<String, dynamic>> pageList = [
    {
      'title': 'The World at Your Fingertips',
      'subTitle':
          'Get 24/7 updates on global news - from breaking politics to cultural trends, all in one place',
      'image': 'assets/images/img intro 1.png',
    },
    {
      'title': 'Tailored to Your Curiosity',
      'subTitle':
          'Select your interests and receive handpicked stories. Technology, sports, or entertainment - we\'ve got you covered',
      'image': 'assets/images/img intro 2.png',
    },
    {
      'title': 'Trusted Updates in Real-Time',
      'subTitle':
          'Instant alerts for breaking news, rigorously fact-checked by our editors before they reach you',
      'image': 'assets/images/img intro 3.png',
    },
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;
  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhite,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: pageList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Image.asset(pageList[index]['image'], height: 300),
                      vsLarge,
                      Text(
                        pageList[index]['title'],
                        style: tsHeadLine3.copyWith(
                          color: cPrimary,
                          fontWeight: fBold,
                        ),
                      ),
                      vsLarge,
                      vsSmall,
                      Text(
                        pageList[index]['subTitle'],
                        textAlign: TextAlign.center,
                        style: tsSubtitle1.copyWith(
                          color: cBlack,
                          fontWeight: fRegular,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
