import 'package:carousel_slider/carousel_slider.dart';
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
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 36),
            // hsSuperTiny,
            Image.asset('assets/images/News Hive.png', height: 24),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),

          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              vsSmall,
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: buildBorder(color: cBlack),
                  focusedBorder: focusBorder,
                  enabledBorder: enabledBorder,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.tune),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Tune Button Pressed')),
                      );
                    },
                  ),
                ),
              ),
              vsSmall,
              DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      labelColor: cBlack,
                      labelStyle: poppinsStyle(
                        fontSize: tsSubtitle2,
                        fontWeight: fSemiBold,
                      ),
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.black,
                      tabs: const [
                        Tab(text: 'Headline'),
                        Tab(text: 'Top Stories'),
                        Tab(text: 'Similar News'),
                      ],
                    ),
                    vsSmall,
                    SizedBox(
                      height: 300,
                      child: TabBarView(
                        children: [
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CarouselSlider(
                                  options: CarouselOptions(
                                    height: 150.0,
                                    enableInfiniteScroll: false,
                                    aspectRatio: 16 / 9,
                                  ),
                                  items:
                                      [
                                        {
                                          'imagePath':
                                              'assets/images/content1.png',
                                          'title': 'Lorem Ipsum Sit Dolor',
                                        },
                                        {
                                          'imagePath':
                                              'assets/images/content2.png',
                                          'title': 'Lorem Ipsum Sit Dolor',
                                        },
                                      ].map((item) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return Stack(
                                              children: [
                                                Container(
                                                  width:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.width,
                                                  margin: EdgeInsets.symmetric(
                                                    horizontal: 5.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                        item['imagePath']!,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8.0,
                                                        ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 7,
                                                  left: 8,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 8.0,
                                                          vertical: 4.0,
                                                        ),
                                                    child: Text(
                                                      item['title']!,
                                                      style: poppinsStyle(
                                                        fontSize: tsSubtitle1,
                                                        fontWeight: fSemiBold,
                                                        color: cTextWhite,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }).toList(),
                                ),
                                vsLarge,

                                Text(
                                  'All News',
                                  style: poppinsStyle(
                                    fontSize: tsSubtitle1,
                                    fontWeight: fSemiBold,
                                    color: cBlack,
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minHeight:
                                            MediaQuery.of(context).size.height,
                                      ),
                                      child: IntrinsicHeight(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(
                                            10,
                                            (index) => Container(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width,
                                              height: 100,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: cWhite,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/content.png',
                                                    height: 100,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Tesla stock jumps after',
                                                      ),
                                                      Text(
                                                        'Business, Technology',
                                                      ),
                                                      Text('2020-12-01'),
                                                    ],
                                                  ),
                                                  Icon(Icons.bookmark),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Center(child: Text('Isi Top Stories')),
                          Center(child: Text('Isi Similar News')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Selected index: $index'),
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
}
