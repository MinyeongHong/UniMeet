import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ServiceTermScreen extends StatefulWidget {
  @override
  State<ServiceTermScreen> createState() => _ServiceTermScreenState();
}

class _ServiceTermScreenState extends State<ServiceTermScreen> {
  WebViewController? controller;

  String url = 'https://sites.google.com/view/momodu-terms-system-ap/%ED%99%88';

  // ios
  // 서비스 이용약관
  // https://sites.google.com/view/momodu-terms-system-ap/%ED%99%88

  // aos
  // 서비스 이용약관
  // https://sites.google.com/view/momodu-terms-system-gg/%ED%99%88

  // @override
  // void initState() {
  //   init();
  //   super.initState();
  // }

  Future<void> init() async {
    if (controller == null) {}
    await controller!.loadUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          "서비스 이용약관",
          style: TextStyle(color: Colors.grey[800]),
        ),
        leading: BackButton(
          color: Colors.grey[800],
        ),
      ),
      body: FutureBuilder(
          future: init(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                return WebView(
                  onWebViewCreated: (WebViewController controller) {
                    this.controller = controller;
                  },
                  initialUrl: url,
                  javascriptMode: JavascriptMode.unrestricted,
                );
              default:
                return Center(
                  child: Text('인터넷 연결을 해주세요.'),
                );
            }
          }),
    );
  }
}
