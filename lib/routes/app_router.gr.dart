// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:drift_tracker/src/features/authentication/presentation/pages/login_page.dart'
    as _i2;
import 'package:drift_tracker/src/features/authentication/presentation/pages/register_page.dart'
    as _i4;
import 'package:drift_tracker/src/features/drift_sessions/presentation/pages/session_detail.dart'
    as _i5;
import 'package:drift_tracker/src/features/drift_sessions/presentation/pages/session_page.dart'
    as _i6;
import 'package:drift_tracker/src/features/home/presentation/pages/home_page.dart'
    as _i1;
import 'package:drift_tracker/src/features/measurement/presentation/pages/pages.dart'
    as _i8;
import 'package:drift_tracker/src/features/profile/presentation/pages/profile_page.dart'
    as _i3;
import 'package:drift_tracker/src/features/splash_screen/splash_screen.dart'
    as _i7;
import 'package:flutter/material.dart' as _i10;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.LoginPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.ProfilePage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.RegisterPage(),
      );
    },
    SessionDetailRoute.name: (routeData) {
      final args = routeData.argsAs<SessionDetailRouteArgs>();
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.SessionDetailPage(
          key: args.key,
          sessionId: args.sessionId,
        ),
      );
    },
    SessionRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.SessionPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.SplashScreen(),
      );
    },
    UserMeasurementRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.UserMeasurementPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute({List<_i9.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ProfilePage]
class ProfileRoute extends _i9.PageRouteInfo<void> {
  const ProfileRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.RegisterPage]
class RegisterRoute extends _i9.PageRouteInfo<void> {
  const RegisterRoute({List<_i9.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.SessionDetailPage]
class SessionDetailRoute extends _i9.PageRouteInfo<SessionDetailRouteArgs> {
  SessionDetailRoute({
    _i10.Key? key,
    required String sessionId,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          SessionDetailRoute.name,
          args: SessionDetailRouteArgs(
            key: key,
            sessionId: sessionId,
          ),
          initialChildren: children,
        );

  static const String name = 'SessionDetailRoute';

  static const _i9.PageInfo<SessionDetailRouteArgs> page =
      _i9.PageInfo<SessionDetailRouteArgs>(name);
}

class SessionDetailRouteArgs {
  const SessionDetailRouteArgs({
    this.key,
    required this.sessionId,
  });

  final _i10.Key? key;

  final String sessionId;

  @override
  String toString() {
    return 'SessionDetailRouteArgs{key: $key, sessionId: $sessionId}';
  }
}

/// generated route for
/// [_i6.SessionPage]
class SessionRoute extends _i9.PageRouteInfo<void> {
  const SessionRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SessionRoute.name,
          initialChildren: children,
        );

  static const String name = 'SessionRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SplashScreen]
class SplashRoute extends _i9.PageRouteInfo<void> {
  const SplashRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.UserMeasurementPage]
class UserMeasurementRoute extends _i9.PageRouteInfo<void> {
  const UserMeasurementRoute({List<_i9.PageRouteInfo>? children})
      : super(
          UserMeasurementRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserMeasurementRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
