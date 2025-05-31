// lib/view/home_screen.dart
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_hive/models/article_model.dart';
import 'package:news_hive/services/news_api_service.dart';
import 'package:news_hive/utils/helper.dart';
import 'package:news_hive/view/news_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsApiService _newsApiService = NewsApiService();
  late Future<List<Article>> _headlineArticlesFuture;
  late Future<List<Article>> _allNewsArticlesFuture;

  final List<String> _categories = [
    'General',
    'Business',
    'Technology',
    'Sports',
    'Health',
    'Science',
    'Entertainment',
  ];
  String _selectedCategory = 'General'; // Kategori default

  final TextEditingController _searchController = TextEditingController();
  String _currentSearchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  void _fetchInitialData() {
    setState(() {
      // Ambil headline dengan negara default 'us' dari service
      _headlineArticlesFuture = _newsApiService.getTopHeadlines(category: _selectedCategory);
      // Ambil "All News" dengan query dan bahasa default dari service
      _allNewsArticlesFuture = _newsApiService.getEverything();
    });
  }

  void _fetchNewsByCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _headlineArticlesFuture = _newsApiService.getTopHeadlines(category: category);
      // Opsional: Bisa juga update _allNewsArticlesFuture berdasarkan kategori jika diinginkan
      // _allNewsArticlesFuture = _newsApiService.getEverything(query: category, language: 'en');
    });
  }

  void _performSearch(String query) {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isNotEmpty) {
      setState(() {
        _currentSearchQuery = trimmedQuery;
        _allNewsArticlesFuture = _newsApiService.getEverything(query: trimmedQuery, language: 'en');
      });
    } else if (_currentSearchQuery.isNotEmpty) {
      setState(() {
        _currentSearchQuery = '';
        _allNewsArticlesFuture = _newsApiService.getEverything(); // Kembali ke default
      });
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'No date';
    try {
      final DateTime dateTime = DateTime.parse(dateString);
      return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
    } catch (e) {
      return dateString;
    }
  }

  Widget _buildArticleImage(
    String? urlToImage, {
    double width = 120,
    double height = 120,
    bool isCarousel = false,
  }) {
    Widget placeholder = Image.asset(
      'assets/images/content.png', // GANTI DENGAN PATH PLACEHOLDER GAMBAR KAMU
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
    if (isCarousel) {
      // Untuk carousel, placeholder bisa lebih generik
      placeholder = Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Icon(Icons.photo_camera_back_outlined, color: Colors.grey[600], size: 50),
      );
    }

    if (urlToImage != null && urlToImage.isNotEmpty) {
      return Image.network(
        urlToImage,
        width: width,
        height: height,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: width,
            height: height,
            color: Colors.grey[200],
            child: Center(
              child: CircularProgressIndicator(
                value:
                    loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                strokeWidth: 2.0,
                color: cPrimary,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          print("Error memuat gambar: $urlToImage, Error: $error");
          return placeholder;
        },
      );
    } else {
      return placeholder;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhite, //
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vsSmall, //
              TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search news...',
                  prefixIcon: const Icon(Icons.search),
                  border: buildBorder(color: cBlack), //
                  focusedBorder: focusBorder, //
                  enabledBorder: enabledBorder, //
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      _performSearch(_searchController.text);
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                onFieldSubmitted: (value) {
                  _performSearch(value);
                },
                onChanged: (value) {
                  if (value.isEmpty && _currentSearchQuery.isNotEmpty) {
                    _performSearch('');
                  }
                },
              ),
              vsMedium, //
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    bool isSelected = _categories[index] == _selectedCategory;
                    return GestureDetector(
                      onTap: () => _fetchNewsByCategory(_categories[index]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _categories[index],
                              style: poppinsStyle(
                                //
                                fontSize: tsSubtitle2, //
                                fontWeight: isSelected ? fSemiBold : fRegular, //
                                color: isSelected ? cPrimary : Colors.grey, //
                              ),
                            ),
                            if (isSelected)
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                height: 2,
                                width: 30,
                                color: cPrimary, //
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              vsMedium, //
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    _fetchInitialData();
                    if (_currentSearchQuery.isNotEmpty) {
                      _performSearch(_currentSearchQuery);
                    }
                  },
                  color: cPrimary, //
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: FutureBuilder<List<Article>>(
                          future: _headlineArticlesFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return SizedBox(
                                height: 150,
                                child: Center(child: CircularProgressIndicator(color: cPrimary)),
                              ); //
                            } else if (snapshot.hasError) {
                              print("Error di FutureBuilder Headline: ${snapshot.error}");
                              print("Stacktrace Error Headline: ${snapshot.stackTrace}");
                              return SizedBox(
                                height: 150,
                                child: Center(
                                  child: Text(
                                    'Oops! Headline Error: ${snapshot.error}',
                                    textAlign: TextAlign.center,
                                    style: poppinsStyle(fontSize: tsCaption, color: cError),
                                  ),
                                ),
                              ); //
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              print(
                                "FutureBuilder Headline: Tidak ada data artikel (country: us, category: $_selectedCategory).",
                              );
                              return SizedBox(
                                height: 150,
                                child: Center(
                                  child: Text(
                                    'No headlines found for $_selectedCategory.',
                                    style: poppinsStyle(fontSize: tsCaption, color: cTextBlue),
                                  ),
                                ),
                              ); //
                            }

                            final allHeadlineArticles = snapshot.data!;
                            print(
                              "FutureBuilder Headline: Dapat ${allHeadlineArticles.length} artikel (country: us, category: $_selectedCategory) sebelum filter gambar.",
                            );

                            final articlesWithImages =
                                allHeadlineArticles
                                    .where((a) => a.urlToImage != null && a.urlToImage!.isNotEmpty)
                                    .take(5)
                                    .toList();
                            print(
                              "FutureBuilder Headline: Dapat ${articlesWithImages.length} artikel SETELAH filter gambar.",
                            );

                            if (articlesWithImages.isEmpty) {
                              return SizedBox(
                                height: 150,
                                child: Center(
                                  child: Text(
                                    'No headlines with images for $_selectedCategory in US.',
                                    style: poppinsStyle(fontSize: tsCaption, color: cTextBlue),
                                  ),
                                ),
                              ); //
                            }

                            return CarouselSlider.builder(
                              itemCount: articlesWithImages.length,
                              itemBuilder: (context, itemIndex, pageViewIndex) {
                                final article = articlesWithImages[itemIndex];
                                return GestureDetector(
                                  onTap:
                                      () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NewsDetailScreen(article: article),
                                        ),
                                      ),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(12.0),
                                          child: _buildArticleImage(
                                            article.urlToImage,
                                            width: double.infinity,
                                            height: 150,
                                            isCarousel: true,
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12.0),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.transparent,
                                                Colors.black.withOpacity(0.8),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 16,
                                          left: 16,
                                          right: 16,
                                          child: Text(
                                            article.title,
                                            style: poppinsStyle(
                                              fontSize: tsSubtitle1,
                                              fontWeight: fSemiBold,
                                              color: cTextWhite,
                                            ), //
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                height: 150.0,
                                viewportFraction: 0.9,
                                enlargeCenterPage: true,
                                enableInfiniteScroll: articlesWithImages.length > 1,
                                autoPlay: articlesWithImages.length > 1,
                                autoPlayInterval: const Duration(seconds: 5),
                              ),
                            );
                          },
                        ),
                      ),
                      SliverToBoxAdapter(child: vsLarge), //
                      SliverToBoxAdapter(
                        child: Text(
                          _currentSearchQuery.isEmpty
                              ? 'All News'
                              : 'Results for: "$_currentSearchQuery"',
                          style: poppinsStyle(
                            fontSize: tsSubtitle1,
                            fontWeight: fSemiBold,
                            color: cBlack,
                          ), //
                        ),
                      ),
                      SliverToBoxAdapter(child: vsMedium), //
                      FutureBuilder<List<Article>>(
                        future: _allNewsArticlesFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting &&
                              _currentSearchQuery.isEmpty) {
                            return SliverFillRemaining(
                              child: Center(child: CircularProgressIndicator(color: cPrimary)),
                            ); //
                          } else if (snapshot.hasError) {
                            print("Error di FutureBuilder AllNews: ${snapshot.error}");
                            print("Stacktrace Error AllNews: ${snapshot.stackTrace}");
                            return SliverFillRemaining(
                              child: Center(
                                child: Text(
                                  'Oops! All News Error: ${snapshot.error}',
                                  textAlign: TextAlign.center,
                                  style: poppinsStyle(fontSize: tsCaption, color: cError),
                                ),
                              ),
                            ); //
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            print(
                              "FutureBuilder AllNews: Tidak ada data artikel untuk query '$_currentSearchQuery'.",
                            );
                            return SliverFillRemaining(
                              child: Center(
                                child: Text(
                                  'No news found for your search.',
                                  style: poppinsStyle(fontSize: tsCaption, color: cTextBlue),
                                ),
                              ),
                            ); //
                          }

                          final articles = snapshot.data!;
                          print(
                            "FutureBuilder AllNews: Dapat ${articles.length} artikel untuk query '$_currentSearchQuery'.",
                          );
                          return SliverList(
                            delegate: SliverChildBuilderDelegate((context, index) {
                              final article = articles[index];
                              return GestureDetector(
                                onTap:
                                    () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NewsDetailScreen(article: article),
                                      ),
                                    ),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: _buildArticleImage(article.urlToImage),
                                      ),
                                      hsMedium, //
                                      Expanded(
                                        child: SizedBox(
                                          height: 120,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                article.title,
                                                style: poppinsStyle(
                                                  fontSize: tsSubtitle1,
                                                  fontWeight: fSemiBold,
                                                  color: cBlack,
                                                ), //
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    article.sourceName ?? 'Unknown Source',
                                                    style: poppinsStyle(
                                                      fontSize: tsCaption,
                                                      color: Colors.grey,
                                                    ), //
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  vsSuperTiny, //
                                                  Text(
                                                    _formatDate(article.publishedAt),
                                                    style: poppinsStyle(
                                                      fontSize: tsCaption,
                                                      color: Colors.grey,
                                                    ), //
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.bookmark_border, color: Colors.grey),
                                        onPressed: () {
                                          /* TODO: Implement bookmark logic */
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }, childCount: articles.length),
                          );
                        },
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
