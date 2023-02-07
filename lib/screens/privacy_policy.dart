import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  late int _selectedIndex = 2;
  var loadingPercentage = 0;
  late final WebViewController controller;
  @override
  void initState() {
    // TODO: implement initState
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
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
        },
      ))
      ..loadRequest(
        Uri.parse('https://advolocate.info/privacy_policy.html'),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              backgroundColor: Colors.yellowAccent,
              color: Theme.of(context).primaryColor,
              value: loadingPercentage / 100.0,
            ),
        ],
      )
          // backgroundColor: Colors.white,
          // appBar: AppBar(
          //   leading: IconButton(
          //     icon: Icon(Icons.arrow_back_ios),
          //     color: Colors.black,
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //   ),
          //   automaticallyImplyLeading: false,
          //   elevation: 0,
          //   iconTheme: const IconThemeData(color: Colors.black),
          //   backgroundColor: Theme.of(context).primaryColor,
          //   title: const Text(
          //     'Privacy Policy',
          //     style: TextStyle(
          //         color: Colors.black,
          //         fontWeight: FontWeight.bold,
          //         letterSpacing: 1),
          //   ),
          //   centerTitle: true,
          // ),
          // body: Padding(
          //   padding: EdgeInsets.only(
          //       top: height * 0.04, left: width * 0.08, right: width * 0.08),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'Privacy Policy',
          //         style: TextStyle(
          //             fontSize: width * 0.08,
          //             fontWeight: FontWeight.bold,
          //             letterSpacing: 0.5),
          //       ),
          //       SizedBox(
          //         height: height * 0.01,
          //       ),
          //       Text(
          //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
          //         style: TextStyle(fontSize: width * 0.045),
          //       )
          //     ],
          //   ),
          ),
    );
  }
}
