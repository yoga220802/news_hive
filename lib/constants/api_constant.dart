import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  static const String baseUrl = 'https://newsapi.org/v2';
  static final String apiKey = dotenv.env['NEWS_API_KEY'] ?? 'API_KEY_GAK_ADA';
  static const String everythingEndpoint = '/everything';
  static const String topHeadlineEndpoint = '/top-headlines';
  static const String sourcesEndpoint = '/top-headlines/sources';

  static const Map<String, String> defaultParams = {'contry': 'us', 'pageSize': '20'};

  // header get
  static Map<String, String> get headers {
    return {"X-Api-Key": apiKey, "Content-Type": "application/json"};
  }

  // auth
  static Map<String, String> get authHeader {
    return {"Authorization": apiKey, "Content-Type": "application/json"};
  }
}
