import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(
          page: LoginRoute.page,
        ),
        AutoRoute(
          page: LeaderboardRoute.page,
        ),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: UserMeasurementRoute.page),
        AutoRoute(page: SessionDetailRoute.page),
        AutoRoute(page: HomeRoute.page, children: [
          AutoRoute(page: SessionRoute.page, initial: true),
          AutoRoute(page: ProfileRoute.page),
        ]),
      ];
}
