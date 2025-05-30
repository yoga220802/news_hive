import 'package:flutter/material.dart';
import '../utils/helper.dart'; // Import helper.dart

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: cBlack),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: cBlack),
            onPressed: () {
              // Fungsi untuk bookmark
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/content1.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16.0), // Spasi
                  // Judul Berita
                  Text(
                    "Trump's trade war hits his second-favorite set of wheels, the golf cart",
                    style: poppinsStyle(
                      fontSize: tsHeadLine3,
                      fontWeight: fBold,
                      color: cBlack,
                    ),
                  ),
                  vsMedium, // Vertical space
                  // Metadata Berita
                  Text(
                    'Publish at March 30, 2025',
                    style: poppinsStyle(fontSize: tsSubtitle2, color: cGrey),
                  ),
                  Text(
                    'Source nbcnews.com',
                    style: poppinsStyle(fontSize: tsSubtitle2, color: cGrey),
                  ),
                  Text(
                    'Category: General, Politics',
                    style: poppinsStyle(fontSize: tsSubtitle2, color: cGrey),
                  ),
                  vsLarge, // Vertical space
                  // Isi Konten Berita
                  Text(
                    'Across the first 100 days of his second term and ups and downs in the level of tariff threats, President Trump, an avid golfer, has often been on the course and photographed in a golf cart, typically a cart made by domestic companies Club Car or E-Z-Go. Across the first 100 days of his second term and ups and downs in the level of tariff threats, President Trump, an avid golfer, has often been on the course and photographed in a golf cart, typically a cart made by domestic companies Club Car or E-Z-Go. Across the first 100 days of his second term and ups and downs in the level of tariff threats, President Trump, an avid golfer, has often been on the course and photographed in a golf cart, typically a cart made by domestic companies Club Car or E-Z-Go.',
                    textAlign: TextAlign.justify,
                    style: poppinsStyle(fontSize: tsSubtitle1, color: cBlack),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
