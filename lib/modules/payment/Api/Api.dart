import 'package:dio/dio.dart';
import 'package:myshoop/shared/network.dart';

class PaymentApi{
  final dio = Dio(BaseOptions(
  baseUrl: paymentLink,
  receiveDataWhenStatusError: true,
  headers: {
    'content-type':'text/xml'
  }));

//   String xmlData = '''
//     <?xml version="1.0" encoding="UTF-8"?>
// <mobile>
// <store>27696</store>
// <key>gbDvh^JM2g#vqMgt</key>
// <device>
// <type>Mobile device type</type>
// <id>Mobile device ID</id>
// <agent>WebView user agent header</agent>
// <accept>WebView accept header</accept>
// </device>
// <app>
// <name>Kash5tak</name>
// <version>1.0.0</version>
// <user>66</user>
// <id>1</id>
// </app>
// <tran>
// <test>0</test>
// <type>paypage</type>
// <class>cont</class>
// <cartid>74</cartid>
// <description>Transaction description</description>
// <currency>SAR</currency>
// <amount>100</amount>
// </tran>
// <card>
// <number>4000000000000002</number>
// <expiry>
// <month>05</month>
// <year>30</year>
// </expiry>
// <cvv>123</cvv>
// </card>
// <billing>
// <name>
// <title>Mr</title>
// <first>Ahmed</first>
// <last>Test</last>
// </name>
// <address>
// <line1>ahmed samy</line1>
// <city>tanta</city>
// <region>tanta</region>
// <country>Country</country>
// <zip>31763</zip>
// </address>
// <phone>+201279568336</phone>
// <email>bavly.naguib@yahoo.com</email>
// </billing>
// </mobile>
//
//         ''';
  post(xmlData) async {
    final response = await dio.post(paymentLink,data: xmlData,);
    return response.data;
  }

  requestStatus(code) async {
    String xmlData = '''
<?xml version="1.0" encoding="UTF-8"?>
<mobile>
<store>27696</store>
<key>gbDvh^JM2g#vqMgt</key>
<complete>$code</complete>
</mobile>
              ''';
    final response = await dio.post(paymentStatus,data: xmlData,);
    return response.data;
  }

}