# flutter_webview_js_basic

This is a demo to show you how to communicate from Flutter to your HTML page, 
then from your HTML page back to your Flutter app.

Reason is I found a lot of really crappy tutorials out in the web (And they are on the top search results! shitty google). 
Some of them are outdated, and most of them just couldn't really explain it clearly 
(and the worst it, write tutorial example without any context, just badly written copy and paste piece)

Again, DIY and you will learn better.

## Quicky 

Just show you the import point here, and you can check the source code later and understand it better.

The most import part is setup your webview, in `lib/src/web_view_stack.dart`

```dart
// skip a bunch of code
        WebView(
          initialUrl: 'about:blank',
          onWebViewCreated: (webViewController) {
            // here we finally put the webViewController back
            widget.controller.complete(webViewController);
            // load the index.html
            _loadIndexFromFlutterAsset(webViewController, context);
          },
          javascriptMode: JavascriptMode.unrestricted,
          // create javascript channel to communicate between webpage and flutter
          javascriptChannels: _createJavascriptChannels(context),
        ),
      ],
// skip a bunch of code
```
the `javascriptMode` and `javascriptChannels` are the two that set it up within the `webview`,
now take a look at the `_createJavascriptChannels` 

```dart
  // javascript channel - received a message then display in a snackbar
  Set<JavascriptChannel> _createJavascriptChannels(BuildContext context) {
    return {
      JavascriptChannel(
        name: 'messageHandler',
        onMessageReceived: (message) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message.message)));
        },
      ),
    };
  }
```

Basically, flutter expect the channel to be in a `Set` (see (JavascriptChannelRegistry)[https://pub.dev/documentation/webview_flutter_platform_interface/latest/webview_flutter_platform_interface/JavascriptChannelRegistry-class.html] for more information)

See the `name: 'messageHandler'`, now in your HTML code (`assets/basic/index.html`):

```js
function sendBack(msg) {
  messageHandler.postMessage(msg);
}
```

And that's it, just call the same key with `postMessage` and your Flutter will get whatever you send from your JS. 

---

Joel Chu (c) 2022
