import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({required this.controller, super.key});

  final Completer<WebViewController> controller;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  // var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          initialUrl: 'about:blank',
          onWebViewCreated: (webViewController) {
            // here we finally put the webViewController back
            widget.controller.complete(webViewController);
            // load the index.html
            _loadIndexFromFlutterAsset(webViewController, context);
          },
          /* onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          }, */
          javascriptMode: JavascriptMode.unrestricted,
          // create javascript channel to communicate between webpage and flutter
          javascriptChannels: _createJavascriptChannels(context),
        ),
        /* if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
          ),*/
      ],
    );
  }

  // javascript channel - received a message then display in a snackbar
  Set<JavascriptChannel> _createJavascriptChannels(BuildContext context) {
    return {
      JavascriptChannel(
        name: 'FLUTTER_JS_CHANNEL',
        onMessageReceived: (message) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message.message)));
        },
      ),
    };
  }

  // loading html assets
  Future<void> _loadIndexFromFlutterAsset(
      WebViewController controller, BuildContext context) async {
    await controller.loadFlutterAsset('assets/basic/index.html');
  }
}
