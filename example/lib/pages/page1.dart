import 'package:app_lifecycle_observer_example/lifecycle/lifecycle.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/page2.dart' as page2;

const pageName = 'page1';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<StatefulWidget> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  void initState() {
    super.initState();

    appLifecycleObserver.subscribe(pageName, (event) {
      print(event);
    });
  }

  @override
  void dispose() {
    appLifecycleObserver.unsubscribe(pageName);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(pageName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              pageName,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.push('/${page2.pageName}');
              },
              child: Text(
                'Go to page2',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
