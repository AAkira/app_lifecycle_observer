sealed class AppLifecycleEvent {
  const AppLifecycleEvent(this.isSystemEvent);

  final bool isSystemEvent;
}

class AppLifecycleEventResumed extends AppLifecycleEvent {
  const AppLifecycleEventResumed(super.isSystemEvent);

  @override
  String toString() =>
      'AppLifecycleEventResumed(isSystemEvent: $isSystemEvent)';
}

class AppLifecycleEventPaused extends AppLifecycleEvent {
  const AppLifecycleEventPaused(super.isSystemEvent);

  @override
  String toString() => 'AppLifecycleEventPaused(isSystemEvent: $isSystemEvent)';
}
