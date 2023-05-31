import 'package:fluter_19pmd/repository/invoice_api.dart';
import "package:flutter/material.dart";
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TestMomo extends StatefulWidget {
  const TestMomo({Key key}) : super(key: key);

  @override
  State<TestMomo> createState() => _TestMomoState();
}

class _TestMomoState extends State<TestMomo> {
  double _progress = 0;
  InAppWebViewController inAppWebViewController;
  @override
  Widget build(BuildContext context) {
  
    return WillPopScope(
      onWillPop: () async {
        var isLastPage = await inAppWebViewController.canGoBack();
        if (isLastPage) {
          inAppWebViewController.goBack();
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              InAppWebView(
                initialUrlRequest:
                    URLRequest(url: Uri.parse(RepositoryInvoice.url)),
                onWebViewCreated: (InAppWebViewController controller) {
                  inAppWebViewController = controller;
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    _progress = progress / 100;
                  });
                },
              ),
              _progress < 1
                  ? Container(
                      child: LinearProgressIndicator(
                        value: _progress,
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
