import 'package:flutter/material.dart';

import '../models/topic.dart';

class TopicTile extends StatelessWidget {
  const TopicTile({super.key, required this.topic, this.onTap});

  final Topic topic;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(topic.title),
      subtitle: Text(topic.publishedAt.toLocal().toString()),
      onTap: onTap,
    );
  }
}
