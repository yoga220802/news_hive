import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_hive/utils/helper.dart';
import 'package:news_hive/view/news_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:news_hive/controllers/news_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<NewsController>(context, listen: false).fetchEverything(query: 'latest');
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsController = Provider.of<NewsController>(context);
    return Scaffold(
      backgroundColor: cWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vsSmall,
              // Search bar
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
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Tune Button Pressed')));
                    },
                  ),
                ),
              ),
              vsMedium,
              // Tab Bar
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        labelColor: cBlack,
                        labelStyle: poppinsStyle(fontSize: tsSubtitle2, fontWeight: fSemiBold),
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.black,
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: const [
                          Tab(text: 'Headline'),
                          Tab(text: 'Top Stories'),
                          Tab(text: 'Similiar News'),
                        ],
                      ),
                      vsMedium,
                      Expanded(
                        child: TabBarView(
                          children: [
                            // Headline Tab
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Carousel - Fixed at top
                                CarouselSlider(
                                  options: CarouselOptions(
                                    height: 150.0,
                                    viewportFraction: 0.9,
                                    enlargeCenterPage: true,
                                    enableInfiniteScroll: false,
                                    onPageChanged: (index, reason) {
                                      setState(() {});
                                    },
                                  ),
                                  items:
                                      [
                                        {
                                          'imagePath': 'assets/images/content1.png',
                                          'title': 'Lorem ipsum sit dolor',
                                        },
                                        {
                                          'imagePath': 'assets/images/content2.png',
                                          'title': 'Lorem ipsum sit dolor',
                                        },
                                      ].map((item) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return Container(
                                              width: MediaQuery.of(context).size.width,
                                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12.0),
                                                image: DecorationImage(
                                                  image: AssetImage(item['imagePath']!),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12.0),
                                                      gradient: LinearGradient(
                                                        begin: Alignment.topCenter,
                                                        end: Alignment.bottomCenter,
                                                        colors: [Colors.transparent, Colors.black],
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 16,
                                                    left: 16,
                                                    right: 16,
                                                    child: Text(
                                                      item['title']!,
                                                      style: poppinsStyle(
                                                        fontSize: tsSubtitle1,
                                                        fontWeight: fSemiBold,
                                                        color: cTextWhite,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      }).toList(),
                                ),
                                vsLarge,
                                // All News Title - Fixed
                                Text(
                                  'All News',
                                  style: poppinsStyle(
                                    fontSize: tsSubtitle1,
                                    fontWeight: fSemiBold,
                                    color: cBlack,
                                  ),
                                ),
                                vsMedium,
                                // News List - Only this section is scrollable
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: newsController.newsModel?.articles?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      final article = newsController.newsModel!.articles![index];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const NewsDetailScreen(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 16),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // News Image
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: Image.network(
                                                  article.urlToImage ??
                                                      'https://via.placeholder.com/120',
                                                  width: 120,
                                                  height: 120,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              hsMedium,
                                              // News Details
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      article.title ?? 'No Title',
                                                      style: poppinsStyle(
                                                        fontSize: tsSubtitle1,
                                                        fontWeight: fSemiBold,
                                                      ),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    vsTiny,
                                                    Text(
                                                      article.source?.name ?? 'Unknown Source',
                                                      style: poppinsStyle(
                                                        fontSize: tsCaption,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    vsTiny,
                                                    Text(
                                                      article.publishedAt?.split('T')[0] ??
                                                          'Unknown Date',
                                                      style: poppinsStyle(
                                                        fontSize: tsCaption,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Bookmark Icon
                                              IconButton(
                                                icon: Icon(Icons.bookmark_border),
                                                onPressed: () {},
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // Top Stories Tab
                            Center(child: Text('Top Stories Content')),
                            // Similar News Tab
                            Center(child: Text('Similar News Content')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
