import 'package:flutter/widgets.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const supportedLocales = [Locale('en'), Locale('ja')];

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static final _localizedValues = <String, Map<String, String>>{
    'en': {
      'morningStretch': 'Morning Stretch',
      'reading': 'Read for 30 minutes',
      'deepBreathing': 'Take 3 deep breaths',
      'addHabit': 'Add Habit',
      'habitNameHint': 'Habit name',
      'cancel': 'Cancel',
      'add': 'Add',
    },
    'ja': {
      'morningStretch': '朝のストレッチ',
      'reading': '30分読書',
      'deepBreathing': '深呼吸3回',
      'addHabit': '習慣を追加',
      'habitNameHint': '習慣名',
      'cancel': 'キャンセル',
      'add': '追加',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']![key] ?? key;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ja'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
