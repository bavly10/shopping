import 'package:flutter/material.dart';
import 'package:shopping/modules/payment/payment.dart';
import 'package:shopping/shared/compononet/blueButton.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xml/xml.dart' as xml;
class Zorar extends StatelessWidget {
var codex;
  Future<dynamic> getLink() async{
    var xml_data = '''
    <?xml version="1.0" encoding="UTF-8"?>
<mobile>
<store>27696</store>
<key>gbDvh^JM2g#vqMgt</key>
<device>
<type>Mobile device type</type>
<id>Mobile device ID</id>
<agent>WebView user agent header</agent>
<accept>WebView accept header</accept>
</device>
<app>
<name>Kash5tak</name>
<version>1.0.0</version>
<user>66</user>
<id>1</id>
</app>
<tran>
<test>0</test>
<type>paypage</type>
<class>cont</class>
<cartid>74</cartid>
<description>Transaction description</description>
<currency>SAR</currency>
<amount>100</amount>
</tran>
<card>
<number>4000000000000002</number>
<expiry>
<month>05</month>
<year>30</year>
</expiry>
<cvv>123</cvv>
</card>
<billing>
<name>
<title>Mr</title>
<first>Ahmed</first>
<last>Test</last>
</name>
<address>
<line1>ahmed samy</line1>
<city>tanta</city>
<region>tanta</region>
<country>Country</country>
<zip>31763</zip>
</address>
<phone>+201279568336</phone>
<email>bavly.naguib@yahoo.com</email>
</billing>
</mobile>

        ''';
    var uri = Uri.parse('https://secure.innovatepayments.com/gateway/mobile.xml');
    var response = await http.post(uri,headers: {
      'content-type':'text/xml'
    },body: xml_data);
    var document = xml.XmlDocument.parse(response.body);
   codex=document.findElements('mobile').first.findElements('webview').first.findElements('code').first.text;
    return document.findElements('mobile').first.findElements('webview').first.findElements('start').first.text;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLink(),
      builder: (context,AsyncSnapshot snapShot){
        if(snapShot.hasData){
          return  BlueButton(title: const Text("Zorar"), hight: 100, width: 100,onpress: () {
            navigateTo(context, Payment(url: snapShot.data,code: codex,));
          },);
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
