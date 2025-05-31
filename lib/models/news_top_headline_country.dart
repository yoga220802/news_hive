import 'article_model.dart';

class NewsTopHeadlineCountryModel {
  String? status;
  int? totalResults;
  List<Article>? articles;

  NewsTopHeadlineCountryModel({this.status, this.totalResults, this.articles});

  factory NewsTopHeadlineCountryModel.fromJson(Map<String, dynamic> json) {
    return NewsTopHeadlineCountryModel(
      status: json['status'],
      totalResults: json['totalResults'],
      articles:
          json['articles'] != null
              ? List<Article>.from(json['articles'].map((x) => Article.fromJson(x)))
              : null,
    );
  }
}
