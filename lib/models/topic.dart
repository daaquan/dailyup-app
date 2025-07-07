class Topic {
  Topic({required this.id, required this.title, required this.url, required this.publishedAt});

  final int id;
  final String title;
  final String url;
  final DateTime publishedAt;

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      url: json['url'] as String? ?? '',
      publishedAt: DateTime.tryParse(json['published_at']?.toString() ?? '') ?? DateTime.now(),
    );
  }
}
