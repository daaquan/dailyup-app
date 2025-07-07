import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/topics_provider.dart';
import '../models/topic.dart';
import '../widgets/topic_tile.dart';
import 'topic_detail.dart';

class TopicsListPage extends StatefulWidget {
  const TopicsListPage({super.key});

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
          Provider.of<TopicsProvider>(context, listen: false).fetchMore();
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
      appBar: AppBar(title: const Text('Topics')),
      body: Consumer<TopicsProvider>(
        builder: (context, provider, _) {
          if (provider.loading && provider.items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.hasError && provider.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Failed to load'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: provider.fetchFirstPage,
                    child: const Text('Retry'),
                  )
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: provider.fetchFirstPage,
            child: ListView.builder(
              controller: _controller,
              itemCount: provider.items.length + (provider.loading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == provider.items.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final topic = provider.items[index];
                return TopicTile(
                  topic: topic,
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
