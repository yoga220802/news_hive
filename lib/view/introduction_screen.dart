import 'package:flutter/material.dart';
import 'package:news_hive/view/login_screen.dart';
import 'package:news_hive/utils/helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
                      vsXLarge,
                      Container(height: 2, color: cPrimary),
                      vsMedium,
                      Text(
                        pageList[index]['title'],
                        style: poppinsStyle(
                          fontSize: tsHeadLine3,
                          fontWeight: fBold,
                          color: cPrimary,
                        ),
                      ),
                      vsSmall,
                      Text(
                        pageList[index]['subTitle'],
                        textAlign: TextAlign.start,
                        style: poppinsStyle(
                          fontSize: tsSubtitle1,
                          fontWeight: fRegular,
                          color: cBlack,
                        ),
                      ),
                      vsSmall,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: pageList.length,
                          effect: ExpandingDotsEffect(
                            activeDotColor: cPrimary,
                            dotColor: cLinear,
                            dotHeight: 15,
                            dotWidth: 15,
                            expansionFactor: 3,
                          ),
                        ),
                      ),
                      Spacer(),
                      if (index == pageList.length - 1)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: cPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(372, 50),
                          ),
                          onPressed: () {
                            // Navigasi ke halaman LoginScreen
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Get Started',
                            style: poppinsStyle(
                              fontSize: tsSubtitle1,
                              fontWeight: fSemiBold,
                              color: cWhite,
                            ),
                          ),
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: cLinear,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: const Size(150, 50),
                              ),
                              onPressed: () {
                                _pageController.jumpToPage(pageList.length - 1);
                              },
                              child: Text(
                                'Skip',
                                style: poppinsStyle(
                                  fontSize: tsSubtitle1,
                                  fontWeight: fSemiBold,
                                  color: cPrimary,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: cPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: const Size(150, 50),
                              ),
                              onPressed: () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                              },
                              child: Text(
                                'Next',
                                style: poppinsStyle(
                                  fontSize: tsSubtitle1,
                                  fontWeight: fSemiBold,
                                  color: cWhite,
                                ),
                              ),
                            ),
                          ],
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
