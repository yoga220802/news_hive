class Article {
  final String? sourceName;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;

  Article({
    this.sourceName,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      sourceName: json['source'] != null ? json['source']['name'] as String? : null,
      author: json['author'] as String?,
      title: json['title'] as String? ?? 'No Title',
      description: json['description'] as String?,
      url: json['url'] as String? ?? '',
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] as String? ?? '',
      content: json['content'] as String?,
    );
  }
}
