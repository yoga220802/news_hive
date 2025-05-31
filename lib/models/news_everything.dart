import 'article_model.dart';

class NewsEverythingModel {
  String? status;
  int? totalResults;
  List<Article>? articles;

  NewsEverythingModel({this.status, this.totalResults, this.articles});

  factory NewsEverythingModel.fromJson(Map<String, dynamic> json) {
    return NewsEverythingModel(
      status: json['status'],
      totalResults: json['totalResults'],
      articles:
          json['articles'] != null
              ? List<Article>.from(json['articles'].map((x) => Article.fromJson(x)))
              : null,
    );
  }
}
