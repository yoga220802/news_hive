class Source {
  String? id;
  String? name;
  String? description;
  String? url;
  Category? category;
  String? language;
  String? country;

  Source({
    this.id,
    this.name,
    this.description,
    this.url,
    this.category,
    this.language,
    this.country,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      url: json['url'],
      category:
          json['category'] != null
              ? Category.values.firstWhere(
                (e) => e.toString().split('.').last == json['category'].toUpperCase(),
                orElse: () => Category.GENERAL,
              )
              : null,
      language: json['language'],
      country: json['country'],
    );
  }
}

enum Category { BUSINESS, ENTERTAINMENT, GENERAL, HEALTH, SCIENCE, SPORTS, TECHNOLOGY }
