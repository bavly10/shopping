import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/modules/Customer/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/cubit/states.dart';
import 'package:shopping/modules/OrderStauts/Success.dart';
import 'package:shopping/modules/OrderStauts/failed.dart';
import 'package:shopping/shared/compononet/blueButton.dart';
import 'package:shopping/shared/compononet/check_phone_cart.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/myToast.dart';
import 'package:shopping/shared/compononet/privacy_dialog.dart';
import 'package:shopping/shared/compononet/sign_up_cart.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:sizer/sizer.dart';

class MyFloating extends StatelessWidget {
  double totalamount = 0.0;
  double? priceShip = 0.0;
  double? priceOwner = 0.0;
  final GlobalKey<ScaffoldState> skey = GlobalKey<ScaffoldState>();
  static double? result;
   MyFloating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var salla = ProductCubit.get(context).privacySalla;
    return BlocConsumer<ProductCubit,ProductStates>(
      listener: (ctx,state){
       if (state is ShopEarnLoadingState ){
          myToast(message:mytranslate(context, "loading"));
        }else if (state is ErrorEarnState){
          myToast(message:mytranslate(context, "error"));
        }else{}
      },
      builder: (ctx,state){
        final cubit = ProductCubit.get(context);
        totalamount = cubit.totalamount;
        final ownerEarn = cubit.ownerEarn;
        ownerEarn!.data!.shopingEarnActive == "true"
            ? priceShip = double.parse("${ownerEarn.data?.shopingEarn}")
            : priceShip = 0.0;
        ownerEarn.data?.ownerEarnActive == "true"
            ? priceOwner = double.parse("${ownerEarn.data?.ownerEarn}")
            : priceOwner = 0.0;
           result = totalamount + priceShip! + priceOwner!;
        return Expanded(
          key: skey,
          child: SingleChildScrollView(
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Center(
                      child: CircleAvatar(
                        backgroundImage: const ExactAssetImage("assets/logo.png"),
                        radius: 9.3.h,
                      ),
                    ),
                    Text(
                      mytranslate(context, "paymentDet"),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(mytranslate(context, "pricee"),
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                        Text(
                            "$totalamount ${mytranslate(context, "wd")}",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(mytranslate(context, "cost"),
                            style: const TextStyle(
                              fontSize: 18,
                            )),
                        ownerEarn.data?.shopingEarnActive == "true"
                            ? Text(
                            "$priceShip ${mytranslate(context, "wd")}",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                            : Text(mytranslate(context, "free"),
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(mytranslate(context, "tax"),
                              style: const TextStyle(
                                fontSize: 18,
                              )),
                          ownerEarn.data?.ownerEarnActive == "true"
                              ? Text(
                              "$priceOwner ${mytranslate(context, "wd")}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold))
                              : Text(mytranslate(context, "free")),
                        ]),
                    const Divider(
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(mytranslate(context, "total"),
                            style: const TextStyle(
                              fontSize: 18,
                            )),
                        Text(
                          "$result ${mytranslate(context, "wd")}",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    BlueButton(
                        color: cubit.items.isEmpty
                            ? Colors.grey[600]
                            : myBlue,
                        title: Text(
                          mytranslate(context, "confirm"),
                          style: TextStyle(
                              color: myWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        onpress: cubit.items.isNotEmpty
                            ? () {
                          if (!cubit.accept) {
                            showDialog(
                                context: skey.currentContext!,
                                builder: (context) {
                                  return PrivacyPolicyDialog(
                                    text: salla!.data,
                                    id: ShopCubit.get(context).userId,
                                  );
                                });
                          }
                        }
                            : null,
                        hight: 0.07,
                        width: MediaQuery.of(context).size.width)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
