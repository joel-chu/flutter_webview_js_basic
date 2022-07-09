import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// import 'src/menu.dart';
// import 'src/navigation_controls.dart';
import 'src/web_view_stack.dart';

void main() {
  runApp(
    const MaterialApp(
      home: WebViewApp(),
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  // notice this controller is init here first and share between each widget
  final controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView'),
        /*actions: [
          NavigationControls(controller: controller),
          Menu(controller: controller),
        ],*/
      ),
      body: WebViewStack(controller: controller),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_upward),
        onPressed: () {
          controller.data!.evaluateJavascript(
              'fromFlutter("from Flutter: press the button")');
        },
      ),
    );
  }
}
