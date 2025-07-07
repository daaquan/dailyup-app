import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/topic.dart';

class TopicDetailPage extends StatelessWidget {
  const TopicDetailPage({super.key, required this.topic});

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Topic Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(topic.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Published: ${topic.publishedAt.toLocal()}'),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                final uri = Uri.parse(topic.url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              child: Text(
                topic.url,
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
