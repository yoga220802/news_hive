// lib/view/news_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:news_hive/models/article_model.dart'; // Import model
import 'package:news_hive/utils/helper.dart';
// import 'package:url_launcher/url_launcher.dart'; // Jika ingin membuka link di browser

class NewsDetailScreen extends StatelessWidget {
  final Article article;

  const NewsDetailScreen({super.key, required this.article});

  String _formatDetailDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'Date not available';
    try {
      final DateTime dateTime = DateTime.parse(dateString);
      // Format yang lebih deskriptif, contoh: March 30, 2025
      // Untuk format yang lebih advanced dan lokalisasi, gunakan package `intl`
      const List<String> months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];
      return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
    } catch (e) {
      return dateString;
    }
  }

  /*
  // Fungsi untuk membuka URL berita asli
  Future<void> _launchArticleUrl() async {
    if (article.url.isNotEmpty) {
      final Uri url = Uri.parse(article.url);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        // Bisa tampilkan snackbar atau dialog jika gagal
        print('Could not launch ${article.url}');
      }
    }
  }
  */

  Widget _buildArticleDetailImage(String? urlToImage) {
    // Mirip dengan di HomeScreen
    if (urlToImage != null && urlToImage.isNotEmpty) {
      return Image.network(
        urlToImage,
        width: double.infinity,
        height: 250, // Sesuaikan tinggi yang diinginkan
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: double.infinity,
            height: 250,
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
          return Container(
            // Placeholder jika error
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12), // Jika ingin ada radius
            ),
            child: Icon(Icons.broken_image_outlined, size: 60, color: Colors.grey[400]),
          );
        },
      );
    } else {
      return Container(
        // Placeholder jika URL gambar tidak ada
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
        child: Icon(Icons.image_not_supported_outlined, size: 60, color: Colors.grey[400]),
      );
    }
  }

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
            icon: const Icon(
              Icons.bookmark_border,
              color: cBlack,
            ), // TODO: Implement bookmark state
            onPressed: () {
              // TODO: Implementasi fungsi bookmark
            },
          ),
          // Opsional: Tombol Share atau Open in Browser
          // IconButton(
          //   icon: const Icon(Icons.share, color: cBlack),
          //   onPressed: () { /* TODO: Implementasi fungsi share */ },
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                // Memberi border radius pada gambar
                borderRadius: BorderRadius.circular(12.0),
                child: _buildArticleDetailImage(article.urlToImage),
              ),
              vsMedium, // SizedBox(height: 16.0)
              Text(
                article.title,
                style: poppinsStyle(
                  fontSize: tsHeadLine3, // Dari helper.dart
                  fontWeight: fBold, // Dari helper.dart
                  color: cBlack, // Dari helper.dart
                ),
              ),
              vsMedium,
              Text(
                'Published at ${_formatDetailDate(article.publishedAt)}',
                style: poppinsStyle(fontSize: tsSubtitle2, color: cGrey),
              ),
              if (article.sourceName != null && article.sourceName!.isNotEmpty)
                Text(
                  'Source: ${article.sourceName}',
                  style: poppinsStyle(fontSize: tsSubtitle2, color: cGrey),
                ),
              if (article.author != null && article.author!.isNotEmpty)
                Text(
                  'Author: ${article.author}',
                  style: poppinsStyle(fontSize: tsSubtitle2, color: cGrey),
                ),
              vsLarge,
              Text(
                // NewsAPI terkadang hanya memberikan deskripsi atau konten yang terpotong.
                // Jika article.content ada dan tidak terpotong (cek apakah diakhiri '[+... chars]'), tampilkan.
                // Jika tidak, tampilkan article.description.
                // Jika keduanya tidak memadai, tampilkan pesan untuk membaca di sumber asli.
                (article.content != null &&
                        article.content!.isNotEmpty &&
                        !article.content!.endsWith('chars]'))
                    ? article.content!
                    : article.description ??
                        'No detailed content available. Please read the full article on the source website.',
                textAlign: TextAlign.justify,
                style: poppinsStyle(fontSize: tsSubtitle1, color: cBlack), // Tambah line height
              ),
              vsLarge,
              if (article.url.isNotEmpty)
                ElevatedButton.icon(
                  icon: Icon(Icons.open_in_new, color: cTextWhite),
                  label: Text(
                    'Read Full Article',
                    style: poppinsStyle(
                      fontSize: tsCaption,
                      color: cTextWhite,
                      fontWeight: fSemiBold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cPrimary,
                    minimumSize: const Size(double.infinity, 50), // Lebar penuh, tinggi 50
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    // _launchArticleUrl(); // Aktifkan jika url_launcher sudah di-setup
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Fitur buka link belum aktif. URL: ${article.url}')),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
