import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;
class Payment extends StatelessWidget {
  final String url;
  final  code;
  String? message;
   Payment({Key? key,required this.url,required this.code,this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 500,
          width: double.infinity,
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(url)),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                allowFileAccessFromFileURLs: true,
                allowUniversalAccessFromFileURLs: true,
                useOnLoadResource: true,
                javaScriptEnabled: true,
              ),
            ),
            onLoadStop: (InAppWebViewController controller, url) async {
              await controller.evaluateJavascript(source: "document.documentElement.innerText")
                  .then((value) async {
                if (value.toString().contains("This process has been completed.")) {
                  print("a7a");
                  var xml_data = '''
<?xml version="1.0" encoding="UTF-8"?>
<mobile>
<store>27696</store>
<key>gbDvh^JM2g#vqMgt</key>
<complete>$code</complete>
</mobile>
              ''';
                  var uri = Uri.parse('https://secure.innovatepayments.com/gateway/mobile_complete.xml');
                  var response = await http.post(uri,headers: {
                    'content-type':'text/xml'
                  },body: xml_data);
                  var document = xml.XmlDocument.parse(response.body);
                  var  message =document.findElements('mobile').first.findElements('auth').first.findElements('message').first.text;
                  var codex =document.findElements('mobile').first.findElements('auth').first.findElements('code').first.text;
                  print(document);
                }  else {
                  null;
                }
              });
            },
          ),
        ),
      ],
    );
  }
}
