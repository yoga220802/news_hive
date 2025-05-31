import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_hive/constants/api_constant.dart';
import 'package:news_hive/models/news_everything.dart';
import 'package:news_hive/models/news_top_headline_country.dart';
import 'package:news_hive/models/news_top_headline_source.dart';

class NewsController with ChangeNotifier {
  NewsEverythingModel? _newsModel;
  NewsTopHeadlineCountryModel? _topHeadlineCountryModel;
  NewsTopHeadlineSourceModel? _newsTopHeadlineSourceModel;
  late bool _isLoading = false;
  String? _errorMessage;

  NewsEverythingModel? get newsModel => _newsModel;
  NewsTopHeadlineCountryModel? get topHeadlineCountryModel => _topHeadlineCountryModel;
  NewsTopHeadlineSourceModel? get newsTopHeadlineSourceModel => _newsTopHeadlineSourceModel;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchEverything({required String query}) async {
    if (_isLoading) return; // Prevent multiple calls
    _isLoading = true;
    notifyListeners(); // Notify listeners only when loading starts
    try {
      final uri = Uri.parse(
        "${ApiConstant.baseUrl}${ApiConstant.everythingEndpoint}?q=$query&pageSize=${ApiConstant.defaultParams['pageSize']}",
      );

      final response = await http.get(uri, headers: ApiConstant.headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _newsModel = NewsEverythingModel.fromJson(data);
        _errorMessage = null;
      } else {
        _errorMessage = "Failed to load news: ${response.reasonPhrase}";
      }
    } catch (error) {
      _errorMessage = "Error fetching news: ${error.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners only after loading finishes
    }
  }

  List<String> filterNews(List<String> articles, String keyword) {
    return articles.where((article) => article.contains(keyword)).toList();
  }
}
