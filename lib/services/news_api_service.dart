// lib/services/news_api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_hive/models/article_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewsApiService {
  final String _apiKey = dotenv.env['NEWS_API_KEY'] ?? 'API_KEY_BELUM_DISET';
  final String _baseUrl = "newsapi.org";

  NewsApiService() {
    if (_apiKey == 'API_KEY_BELUM_DISET' || _apiKey.isEmpty) {
      print(
        'Peringatan: API Key belum diset atau tidak valid. Beberapa fitur mungkin tidak berfungsi.',
      );
    }
  }

  Future<List<Article>> getTopHeadlines({
    String country = 'id', // Default negara US
    String category = '',
    int pageSize = 20, // NewsAPI default page size
    int page = 1,
  }) async {
    if (_apiKey == 'API_KEY_BELUM_DISET' || _apiKey.isEmpty) {
      throw Exception('API Key tidak valid atau belum diset. Tidak dapat mengambil berita utama.');
    }

    final Map<String, String> queryParameters = {
      'apiKey': _apiKey,
      'country': country,
      'pageSize': pageSize.toString(),
      'page': page.toString(),
    };

    if (category.isNotEmpty && category.toLowerCase() != 'general') {
      queryParameters['category'] = category.toLowerCase();
    }

    final uri = Uri.https(_baseUrl, '/v2/top-headlines', queryParameters);
    print('Mengambil Top Headlines (Negara: $country, Kategori: $category) dari: $uri');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'ok') {
          if (jsonResponse['articles'] == null) {
            // Tambahan cek jika 'articles' null
            print("Respons API 'ok' tapi field 'articles' null untuk $country/$category.");
            return []; // Kembalikan list kosong jika tidak ada artikel
          }
          final List articlesJson = jsonResponse['articles'];
          return articlesJson
              .map((jsonMap) => Article.fromJson(jsonMap as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception(
            'Gagal mengambil berita utama dari API (status bukan ok): ${jsonResponse['message']} (Negara: $country, Kategori: $category)',
          );
        }
      } else {
        throw Exception(
          'Gagal mengambil berita utama. Status HTTP: ${response.statusCode}, Pesan: ${response.body} (Negara: $country, Kategori: $category)',
        );
      }
    } catch (e) {
      print('Terjadi error saat mengambil Top Headlines: $e');
      throw Exception('Gagal terhubung ke layanan berita: $e');
    }
  }

  Future<List<Article>> getEverything({
    String query = 'indonesia', // Default query
    String sortBy = 'publishedAt',
    String language = 'id', // Default bahasa Inggris
    int pageSize = 40,
    int page = 1,
    String? sources,
    String? domains,
  }) async {
    if (_apiKey == 'API_KEY_BELUM_DISET' || _apiKey.isEmpty) {
      throw Exception('API Key tidak valid atau belum diset. Tidak dapat mengambil semua berita.');
    }

    final Map<String, String> queryParameters = {
      'apiKey': _apiKey,
      'q': query.isNotEmpty ? query : 'latest news',
      'sortBy': sortBy,
      'language': language,
      'pageSize': pageSize.toString(),
      'page': page.toString(),
    };

    if (sources != null && sources.isNotEmpty) {
      queryParameters['sources'] = sources;
    }
    if (domains != null && domains.isNotEmpty) {
      queryParameters['domains'] = domains;
    }

    final uri = Uri.https(_baseUrl, '/v2/everything', queryParameters);
    print('Mengambil Semua Berita (Query: "$query", Bahasa: $language) dari: $uri');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'ok') {
          if (jsonResponse['articles'] == null) {
            print("Respons API 'ok' tapi field 'articles' null untuk query '$query'.");
            return [];
          }
          final List articlesJson = jsonResponse['articles'];
          return articlesJson
              .map((jsonMap) => Article.fromJson(jsonMap as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception(
            'Gagal mengambil semua berita dari API (status bukan ok): ${jsonResponse['message']} (Query: $query)',
          );
        }
      } else {
        throw Exception(
          'Gagal mengambil semua berita. Status HTTP: ${response.statusCode}, Pesan: ${response.body} (Query: $query)',
        );
      }
    } catch (e) {
      print('Terjadi error saat mengambil Semua Berita: $e');
      throw Exception('Gagal terhubung ke layanan berita: $e');
    }
  }
}
