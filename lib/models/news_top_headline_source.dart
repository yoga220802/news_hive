import 'package:news_hive/models/source_model.dart';

class NewsTopHeadlineSourceModel {
  String? status;
  List<Source>? sources;

  NewsTopHeadlineSourceModel({this.status, this.sources});

  factory NewsTopHeadlineSourceModel.fromJson(Map<String, dynamic> json) {
    return NewsTopHeadlineSourceModel(
      status: json['status'],
      sources:
          json['sources'] != null
              ? List<Source>.from(json['sources'].map((x) => Source.fromJson(x)))
              : null,
    );
  }
}
