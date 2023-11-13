# app_lifecycle_observer

This library is a Flutter lifecycle observer independent of context.

## Futures

It can handle resume(AppLifecycleEventResumed) and pause(AppLifecycleEventPaused) lifecycle events.

* Observe app lifecycle events
e.g. screen on/off, app to home, open notification center etc...
 
* Observe app navigator events
e.g. navigator event as push, pop, replace, remove, etc...

### isSystemEvent

The isSystemEvent flag can be used to determine whether the event is a lifecycle event caused by
navigation or a system event such as a screen on/off.

| Event                              | isSystemEvent |
|------------------------------------|---------------|
| screen on/off, app to home, etc... | true          |
| navigator event(push, pop, etc...) | false         |

## Getting Started

This library does not use ModalRoute(i.e., no Context is needed), but instead uses MaterialPage's
name to match lifecycle events.  
Therefore, please include the name of the page in the MaterialPage name.

This library can be used with any Navigation: Navigator, Router, GoRouter.

* First

Set the AppLifecycleObserver to your routeObserver.  
If you have nested Routes such as BottomNavigation, you need to set appLifecycleObserver as well.

* Second

Set a page name to your MaterialPage name.

* Third

Call unsubscribe if you no longer need to observe the event.

### GoRouter example

```dart

final appLifecycleObserver = AppLifecycleObserver();

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
      path: '/page1',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          name: 'page1',
          child: const Page1(),
        );
      },
    ),
    GoRoute(
      path: '/page2',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          name: 'page2',
          child: const page2.Page2(),
        );
      },
    ),
  ],
);
```

### Observer example

* subscribe

```dart
final appLifecycleObserver = AppLifecycleObserver();

appLifecycleObserver.subscribe('pageName', (event) {
    print(event);
});
```

* unsubscribe

```dart

appLifecycleObserver.unsubscribe('pageName');
```
