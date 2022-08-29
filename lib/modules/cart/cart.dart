import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/Customer/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/cubit/states.dart';
import 'package:shopping/modules/OrderStauts/Success.dart';
import 'package:shopping/modules/OrderStauts/failed.dart';
import 'package:shopping/modules/cart/widget/widget_cart.dart';
import 'package:shopping/modules/mainScreen/mainScreen.dart';
import 'package:shopping/modules/mainScreen/screen/singleCustomerProduct/mainCustomer.dart';
import 'package:shopping/shared/compononet/blueButton.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/sign_up_dialog.dart';
import 'package:shopping/shared/compononet/verification_phone_dialog.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

import '../../shared/compononet/check_phone_cart.dart';
import '../../shared/compononet/sign_up_cart.dart';

class CartScreen extends StatelessWidget {
  double x = 0.0;
  double y = 0.0;
  double d = 30.0;
  final GlobalKey<ScaffoldState> skey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (ctx, state) {
        if (state is InsertOrderSucessState) {
          navigateToFinish(
              context,
              const SuccessOrder(
                phone: "06510355051",
              ));
        } else if (state is InsertOrderErrorState) {
          navigateToFinish(context, const FailedOrder());
        }
      },
      builder: (ctx, state) {
        final cubit = ProductCubit.get(context);
        x = cubit.totalamount;
        var totall = (x + d);
        return SafeArea(
          child: Scaffold(
            key: skey,
            body: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          mytranslate(context, "prod"),
                          style: TextStyle(
                              color: myBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "${cubit.itemcount}",
                          style: TextStyle(
                              color: myBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Text(
                                mytranslate(context, "bag"),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: cubit.items.isEmpty
                        ? Center(
                            child: Text(
                            mytranslate(context, "empty"),
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: myBlue),
                          ))
                        : ListView.builder(
                            itemCount: cubit.items.length,
                            itemBuilder: (ctx, index) => Cartitemapp(
                                  size: cubit.items.values.toList()[index].size,
                                  id: cubit.items.values.toList()[index].id,
                                  proid: cubit.items.keys.toList()[index],
                                  title:
                                      cubit.items.values.toList()[index].title,
                                  imgurl:
                                      cubit.items.values.toList()[index].imgurl,
                                  quant: cubit.items.values
                                      .toList()[index]
                                      .quantity,
                                  price:
                                      cubit.items.values.toList()[index].price,
                                )),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width * .6,
                      color: Colors.black45,
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    // height: MediaQuery.of(context).size.height * .3,
                    color: myLightBlue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(mytranslate(context, "price"),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400)),
                              Text("$x ${mytranslate(context, "wd")}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(mytranslate(context, "cost"),
                                  style: const TextStyle(
                                    fontSize: 18,
                                  )),
                              Text(
                                  "${d.toStringAsFixed(2)} ${mytranslate(context, "wd")}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const Divider(
                            color: Colors.blueAccent,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(mytranslate(context, "total"),
                                  style: const TextStyle(
                                    fontSize: 18,
                                  )),
                              Text(
                                  "${totall.toStringAsFixed(2)} ${mytranslate(context, "wd")}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ],
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
                                      showDialog(
                                          context: skey.currentContext!,
                                          builder: (context) {
                                            return CheckDialog(
                                              widget: SignupCartDialog(
                                                onTaps: () {
                                                  cubit.items.forEach(
                                                      (key, value) async {
                                                    print(
                                                        value.size.toString());
                                                    print(value.id.toString());
                                                    print(CustomerCubit.get(
                                                            context)
                                                        .userId);
                                                    await cubit.createOrder(
                                                      size:
                                                          value.size.toString(),
                                                      price: value.price
                                                          .toString(),
                                                      many: value.quantity
                                                          .toString(),
                                                      customerID:
                                                          CustomerCubit.get(
                                                                  context)
                                                              .userId,
                                                      productID:
                                                          value.id.toString(),
                                                    );
                                                  });
                                                },
                                              ),
                                            );
                                          });
                                    }
                                  : null,
                              hight: 0.07,
                              width: MediaQuery.of(context).size.width)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
