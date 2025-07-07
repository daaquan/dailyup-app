import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/topics_provider.dart';
import 'topics_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController(text: 'news');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Category',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final category = _controller.text.trim();
                if (category.isEmpty) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      create: (_) => TopicsProvider()..fetch(category: category),
                      child: TopicsListPage(category: category),
                    ),
                  ),
                );
              },
              child: const Text('Show Topics'),
            ),
          ],
        ),
      ),
    );
  }
}
