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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ChangeNotifierProvider(
        create: (_) => TopicsProvider()..fetchFirstPage(),
        child: const TopicsListPage(),
      ),
    );
  }
}
