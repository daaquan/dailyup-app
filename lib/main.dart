import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'l10n/l10n.dart';

void main() {
  runApp(const DailyUpApp());
}

class DailyUpApp extends StatelessWidget {
  const DailyUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DailyUp',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent).copyWith(
          secondary: Colors.tealAccent,
        ),
        textTheme: GoogleFonts.fredokaTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HabitListPage(),
    );
  }
}

class HabitItem {
  HabitItem({required this.icon, required this.title});
  final String icon;
  final String title;
  bool done = false;
}

class HabitListPage extends StatefulWidget {
  const HabitListPage({super.key});

  @override
  State<HabitListPage> createState() => _HabitListPageState();
}

class _HabitListPageState extends State<HabitListPage> {
  final List<HabitItem> _habits = [
    HabitItem(icon: '🌞', title: 'morningStretch'),
    HabitItem(icon: '📖', title: 'reading'),
    HabitItem(icon: '🧘', title: 'deepBreathing'),
  ];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DailyUp',
          style: GoogleFonts.fredoka(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _habits.length,
          itemBuilder: (context, index) {
            final item = _habits[index];
            return Dismissible(
              key: ValueKey(item),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.redAccent,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) => setState(() => _habits.removeAt(index)),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(item.icon, style: const TextStyle(fontSize: 24)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          loc.translate(item.title),
                          style: GoogleFonts.fredoka(fontSize: 18),
                        ),
                      ),
                      Checkbox(
                        value: item.done,
                        onChanged: (value) {
                          setState(() {
                            item.done = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        child: const Icon(Icons.add),
        onPressed: () async {
          _controller.clear();
          final result = await showDialog<String>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(loc.addHabit),
              content: TextField(
                controller: _controller,
                decoration: InputDecoration(hintText: loc.habitNameHint),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(loc.cancel),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, _controller.text),
                  child: Text(loc.add),
                ),
              ],
            ),
          );
          if (result != null && result.isNotEmpty) {
            setState(() {
              _habits.add(HabitItem(icon: '❤️', title: result));
            });
          }
        },
      ),
    );
  }
}
