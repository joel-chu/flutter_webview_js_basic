// Just build a button :S
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ButtonControl extends StatelessWidget {
  const ButtonControl({required this.controller, super.key});

  final Completer<WebViewController> controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller.future,
      builder: (context, snapshot) {
        final WebViewController? controller = snapshot.data;
        if (snapshot.connectionState != ConnectionState.done ||
            controller == null) {
          return FloatingActionButton(
            child: const Icon(Icons.arrow_upward),
            onPressed: () {},
          );
        }

        return FloatingActionButton(
          child: const Icon(Icons.arrow_upward),
          onPressed: () {
            controller.data!.evaluateJavascript(
                'fromFlutter("from Flutter: press the button")');
          },
        );
      },
    );
  }
}
