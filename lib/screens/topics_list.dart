import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/topics_provider.dart';
import '../models/topic.dart';
import 'topic_detail.dart';

class TopicsListPage extends StatefulWidget {
  const TopicsListPage({super.key, required this.category});

  final String category;

  @override
  State<TopicsListPage> createState() => _TopicsListPageState();
}

class _TopicsListPageState extends State<TopicsListPage> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.position.pixels >=
                _controller.position.maxScrollExtent - 200) {
          Provider.of<TopicsProvider>(context, listen: false)
              .loadMore(category: widget.category);
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Topics: ${widget.category}')),
      body: Consumer<TopicsProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.topics.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.hasError && provider.topics.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Failed to load'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => provider.fetch(category: widget.category),
                    child: const Text('Retry'),
                  )
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => provider.fetch(category: widget.category),
            child: ListView.builder(
              controller: _controller,
              itemCount: provider.topics.length + (provider.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == provider.topics.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final topic = provider.topics[index];
                return ListTile(
                  title: Text(topic.title),
                  subtitle: Text(topic.publishedAt.toLocal().toString()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TopicDetailPage(topic: topic),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
