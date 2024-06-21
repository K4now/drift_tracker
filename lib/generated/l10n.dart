// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Session`
  String get session {
    return Intl.message(
      'Session',
      name: 'session',
      desc: '',
      args: [],
    );
  }

  /// `Car Details`
  String get carDetails {
    return Intl.message(
      'Car Details',
      name: 'carDetails',
      desc: '',
      args: [],
    );
  }

  /// `Car Brand`
  String get carBrand {
    return Intl.message(
      'Car Brand',
      name: 'carBrand',
      desc: '',
      args: [],
    );
  }

  /// `Horsepower`
  String get horsepower {
    return Intl.message(
      'Horsepower',
      name: 'horsepower',
      desc: '',
      args: [],
    );
  }

  /// `Configuration`
  String get config {
    return Intl.message(
      'Configuration',
      name: 'config',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get fieldRequired {
    return Intl.message(
      'This field is required',
      name: 'fieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid number`
  String get enterValidNumber {
    return Intl.message(
      'Please enter a valid number',
      name: 'enterValidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Save Car Details`
  String get saveCarDetails {
    return Intl.message(
      'Save Car Details',
      name: 'saveCarDetails',
      desc: '',
      args: [],
    );
  }

  /// `Car details saved successfully`
  String get carDataSaved {
    return Intl.message(
      'Car details saved successfully',
      name: 'carDataSaved',
      desc: '',
      args: [],
    );
  }

  /// `Car details loaded successfully`
  String get carDataLoaded {
    return Intl.message(
      'Car details loaded successfully',
      name: 'carDataLoaded',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Enter car brand`
  String get enterCarBrand {
    return Intl.message(
      'Enter car brand',
      name: 'enterCarBrand',
      desc: '',
      args: [],
    );
  }

  /// `Enter horsepower`
  String get enterHorsepower {
    return Intl.message(
      'Enter horsepower',
      name: 'enterHorsepower',
      desc: '',
      args: [],
    );
  }

  /// `Enter configuration`
  String get enterConfig {
    return Intl.message(
      'Enter configuration',
      name: 'enterConfig',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Show Details`
  String get showDetails {
    return Intl.message(
      'Show Details',
      name: 'showDetails',
      desc: '',
      args: [],
    );
  }

  /// `Hide Details`
  String get hideDetails {
    return Intl.message(
      'Hide Details',
      name: 'hideDetails',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Edit Car Details`
  String get editCarDetails {
    return Intl.message(
      'Edit Car Details',
      name: 'editCarDetails',
      desc: '',
      args: [],
    );
  }

  /// `Points`
  String get points {
    return Intl.message(
      'Points',
      name: 'points',
      desc: '',
      args: [],
    );
  }

  /// `Current Velocity`
  String get currentVelocity {
    return Intl.message(
      'Current Velocity',
      name: 'currentVelocity',
      desc: '',
      args: [],
    );
  }

  /// `Max Angle`
  String get maxAngle {
    return Intl.message(
      'Max Angle',
      name: 'maxAngle',
      desc: '',
      args: [],
    );
  }

  /// `Calibrate`
  String get calibrate {
    return Intl.message(
      'Calibrate',
      name: 'calibrate',
      desc: '',
      args: [],
    );
  }

  /// `Save Session`
  String get saveSession {
    return Intl.message(
      'Save Session',
      name: 'saveSession',
      desc: '',
      args: [],
    );
  }

  /// `Start Test`
  String get startTest {
    return Intl.message(
      'Start Test',
      name: 'startTest',
      desc: '',
      args: [],
    );
  }

  /// `Increase Speed`
  String get increaseSpeed {
    return Intl.message(
      'Increase Speed',
      name: 'increaseSpeed',
      desc: '',
      args: [],
    );
  }

  /// `Decrease Speed`
  String get decreaseSpeed {
    return Intl.message(
      'Decrease Speed',
      name: 'decreaseSpeed',
      desc: '',
      args: [],
    );
  }

  /// `Increase Angle`
  String get increaseAngle {
    return Intl.message(
      'Increase Angle',
      name: 'increaseAngle',
      desc: '',
      args: [],
    );
  }

  /// `Decrease Angle`
  String get decreaseAngle {
    return Intl.message(
      'Decrease Angle',
      name: 'decreaseAngle',
      desc: '',
      args: [],
    );
  }

  /// `Simulate Transition`
  String get simulateTransition {
    return Intl.message(
      'Simulate Transition',
      name: 'simulateTransition',
      desc: '',
      args: [],
    );
  }

  /// `Current Angle`
  String get currentAngle {
    return Intl.message(
      'Current Angle',
      name: 'currentAngle',
      desc: '',
      args: [],
    );
  }

  /// `Session saved`
  String get session_saved {
    return Intl.message(
      'Session saved',
      name: 'session_saved',
      desc: '',
      args: [],
    );
  }

  /// `Leaderboard`
  String get leaderboard {
    return Intl.message(
      'Leaderboard',
      name: 'leaderboard',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
