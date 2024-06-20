import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LanguageEvent { changeToEnglish, changeToRussian }

class LanguageState {
  final Locale locale;

  LanguageState(this.locale);
}

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  static const String prefKey = "language_code";

  LanguageBloc() : super(LanguageState(Locale('en'))) {
    on<LanguageEvent>((event, emit) async {
      final locale = event == LanguageEvent.changeToEnglish ? Locale('en') : Locale('ru');
      await _saveLocale(locale);
      emit(LanguageState(locale));
    });
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(prefKey) ?? 'en';
    // ignore: invalid_use_of_visible_for_testing_member
    emit(LanguageState(Locale(languageCode)));
  }

  Future<void> _saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefKey, locale.languageCode);
  }
}
