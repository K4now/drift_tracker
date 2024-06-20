import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:drift_tracker/generated/l10n.dart';
import 'package:drift_tracker/routes/app_router.gr.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        SessionRoute(),
        ProfileRoute(),
      ],
     
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: S.of(context).session,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: S.of(context).profile,
            ),
          ],
        );
      },
    );
  }
}
