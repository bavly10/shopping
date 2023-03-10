
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/payment/Api/Api.dart';
import 'package:shopping/modules/payment/cubit/state.dart';
import 'package:xml/xml.dart' as xml;

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit() : super(PaymentInitalState());
  static PaymentCubit get(context) => BlocProvider.of(context);



  dynamic codeTran;
   String? url;
  Future getLink({phone, email, firstName, lastName, address, amount}) async{
    emit(PaymentLoading());
    var response = await PaymentApi().post(myData(phone: phone,email:email,amount:amount, address: address,firstName:firstName,lastName: lastName));
    var document = xml.XmlDocument.parse(response);
    codeTran=document.findElements('mobile').first.findElements('webview').first.findElements('code').first.text;
    url= document.findElements('mobile').first.findElements('webview').first.findElements('start').first.text;
    debugPrint(response,);
    debugPrint(url!,);
    debugPrint(codeTran,);
    emit(PaymentLinkDone());
  }

  String? status;
  String? message;
  Future requestPayment()async{
    emit(RequestPaymentLoading());
    var response = await PaymentApi().requestStatus(codeTran);
    var document = xml.XmlDocument.parse(response);
      message =document.findElements('mobile').first.findElements('auth').first.findElements('message').first.text;
    status =document.findElements('mobile').first.findElements('auth').first.findElements('status').first.text;
    debugPrint(status!+message!,);
    debugPrint(response);
    emit(RequestPaymentDone());
  }

  String myData({required String email,required String firstName,required String lastName,required String address,required String phone,required String amount,}){
    var rng =Random();
    var cartId = rng.nextDouble() * 10000;
    while (cartId < 1000) {
      cartId *= 10;
      print(cartId);
    }
    return ''' 
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
<test>1</test>
<type>paypage</type>
<class>cont</class>
<cartid>$cartId</cartid>
<description>Kash5tak</description>
<currency>SAR</currency>
<amount>$amount</amount>
</tran>
<billing>
<name>
<first>$firstName</first>
<last>$lastName</last>
</name>
<address>
<line1>$address</line1>
<city>City</city>
<region>tanta</region>
<country>Country</country>
<zip>11461</zip>
</address>
<phone>$phone</phone>
<email>$email</email>
</billing>
</mobile>
    ''';
  }
}
