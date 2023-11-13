import 'package:flutter/widgets.dart';

import 'app_lifecycle_event.dart';

typedef AppLifecycleObserverCallback = void Function(AppLifecycleEvent event);

class AppLifecycleObserver extends NavigatorObserver {
  AppLifecycleObserver() {
    _appLifecycleListener = AppLifecycleListener(
      onResume: () {
        _emitLifecycleEvent(
            _routeStack.last, const AppLifecycleEventResumed(true));
      },
      onPause: () {
        _emitLifecycleEvent(
            _routeStack.last, const AppLifecycleEventPaused(true));
      },
    );
  }

  late final AppLifecycleListener _appLifecycleListener;

  final Map<String, Set<AppLifecycleObserverCallback>> _subscribers =
      <String, Set<AppLifecycleObserverCallback>>{};

  final List<Route<dynamic>> _routeStack = [];

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routeStack.remove(route);

    _emitLifecycleEvent(route, const AppLifecycleEventPaused(false));
    _emitLifecycleEvent(previousRoute, const AppLifecycleEventResumed(false));
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routeStack.add(route);

    _emitLifecycleEvent(previousRoute, const AppLifecycleEventPaused(false));
    _emitLifecycleEvent(route, const AppLifecycleEventResumed(false));
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (_routeStack.last == route) {
      _emitLifecycleEvent(route, const AppLifecycleEventPaused(false));
      _emitLifecycleEvent(previousRoute, const AppLifecycleEventResumed(false));
    }
    _routeStack.remove(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    final index = _routeStack.indexWhere((element) => element == oldRoute);
    if (_routeStack.last == oldRoute) {
      _emitLifecycleEvent(oldRoute, const AppLifecycleEventPaused(false));
    }
    _routeStack.remove(oldRoute);

    if (index >= 0 && newRoute != null) {
      _routeStack.insert(index, newRoute);
    }
    if (_routeStack.last == newRoute) {
      _emitLifecycleEvent(newRoute, const AppLifecycleEventResumed(false));
    }
  }

  void dispose() {
    _appLifecycleListener.dispose();
    _subscribers.clear();
  }

  void subscribe(String key, AppLifecycleObserverCallback callback) {
    final Set<AppLifecycleObserverCallback> subscribers =
        _subscribers.putIfAbsent(key, () => {});
    subscribers.add(callback);

    if (_routeStack.isNotEmpty && _routeStack.last.settings.name == key) {
      _emitLifecycleEvent(
          _routeStack.last, const AppLifecycleEventResumed(false));
    }
  }

  void unsubscribe(String key) {
    _subscribers.remove(key);
  }

  void _emitLifecycleEvent(Route<dynamic>? route, AppLifecycleEvent event) {
    final key = route?.settings.name;
    if (key == null) {
      return;
    }

    final subscribers = _subscribers[key];
    if (subscribers == null) {
      return;
    }
    for (final subscriber in subscribers) {
      subscriber.call(event);
    }
  }
}
