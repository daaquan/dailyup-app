class Topic {
  Topic({required this.title, required this.link, required this.publishedAt});

  final String title;
  final String link;
  final DateTime publishedAt;

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      title: json['title'] as String? ?? '',
      link: json['link'] as String? ?? '',
      publishedAt: DateTime.tryParse(json['published_at']?.toString() ?? '') ?? DateTime.now(),
    );
  }
}
