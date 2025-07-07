import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'l10n/l10n.dart';
import 'screens/home.dart';

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
      home: const HomePage(),
    );
  }
}
