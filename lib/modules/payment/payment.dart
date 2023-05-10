import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:myshoop/modules/Customer/cubit/cubit.dart';
import 'package:myshoop/modules/Customer/products/cubit/cubit.dart';
import 'package:myshoop/modules/Customer/products/cubit/states.dart';
import 'package:myshoop/modules/OrderStauts/Success.dart';
import 'package:myshoop/modules/OrderStauts/failed.dart';
import 'package:myshoop/modules/payment/cubit/cubit.dart';
import 'package:myshoop/modules/payment/cubit/state.dart';
import 'package:myshoop/shared/compononet/check_phone_cart.dart';
import 'package:myshoop/shared/compononet/componotents.dart';
import 'package:myshoop/shared/compononet/sign_up_cart.dart';

class Payment extends StatelessWidget {
  final String url;
  final  code;
  String? message;
   Payment({Key? key,required this.url,required this.code,this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit,ProductStates>(
      builder: (ctx,state){
        final cubit=ProductCubit.get(context);
        return InAppWebView(
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
                 PaymentCubit.get(context).requestPayment().then((value) =>{
                   if (PaymentCubit.get(context).status=="A"){
                     CustomerCubit.get(context).createUser(
                     name: SignUpCartDialog.firstNameController.text,
                     address: SignUpCartDialog.addressController.text,
                     email: SignUpCartDialog.emailController.text,
                     phone: CheckDialog.phoneCheckController.text)
                     .then((value) => {
                   cubit.items.forEach((key, value) async {
                     await cubit.createOrder(size: value.size.toString(), price: value.price.toString(), many: value.quantity.toString(),
                         customerID: CustomerCubit.get(context).userId, productID: value.id.toString() );
                   }),
                   ProductCubit.get(context).accept = false
                 }).whenComplete(() => {
                   navigateToFinish(context, const SuccessOrder(phone: "06510355051",)),
                   ProductCubit.get(context).removeCart()
                 })
                   }else{
                     navigateToFinish(context, FailedOrder())
                   }
                 });
              }  else {
                null;
              }
            });
          },
        );
      },
    );
  }
}
