import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../lifecycle/lifecycle.dart';
import '../pages/home_page.dart';
import '../pages/page1.dart' as page1;
import '../pages/page2.dart' as page2;

final goRouter = GoRouter(
  initialLocation: '/',
  observers: [
    appLifecycleObserver,
  ],
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          name: '/',
          child: const HomePage(),
        );
      },
    ),
    GoRoute(
      path: '/${page1.pageName}',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          name: page1.pageName,
          child: const page1.Page1(),
        );
      },
    ),
    GoRoute(
      path: '/${page2.pageName}',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          name: page2.pageName,
          child: const page2.Page2(),
        );
      },
    ),
  ],
);
