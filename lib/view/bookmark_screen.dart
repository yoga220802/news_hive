import 'package:flutter/material.dart';
import 'package:news_hive/utils/helper.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Saved Articles',
                style: poppinsStyle(
                  fontSize: tsSubtitle1,
                  fontWeight: fSemiBold,
                  color: cBlack,
                ),
              ),
              vsMedium,
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/content.png',
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          hsMedium,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Bookmarked Article ${index + 1}',
                                  style: poppinsStyle(
                                    fontSize: tsSubtitle1,
                                    fontWeight: fSemiBold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                vsTiny,
                                Text(
                                  'Category',
                                  style: poppinsStyle(
                                    fontSize: tsCaption,
                                    color: Colors.grey,
                                  ),
                                ),
                                vsTiny,
                                Text(
                                  '2020-12-01',
                                  style: poppinsStyle(
                                    fontSize: tsCaption,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.bookmark, color: cPrimary),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
