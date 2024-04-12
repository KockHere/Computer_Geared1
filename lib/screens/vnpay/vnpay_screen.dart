import 'package:flutter/material.dart';
import 'package:shop_app/controllers/VnPayAPI.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VnPayScreen extends StatefulWidget {
  const VnPayScreen({super.key, required this.url});

  final String url;

  @override
  State<VnPayScreen> createState() => _VnPayScreenState();
}

class _VnPayScreenState extends State<VnPayScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    final WebViewController controller = WebViewController();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            if (url.contains("https://pc-gear-capstone-backup.onrender.com/")) {
              VnPayAPI.finishPayment(url).then((data) {
                Navigator.pop(context, data);
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('VNPay'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
