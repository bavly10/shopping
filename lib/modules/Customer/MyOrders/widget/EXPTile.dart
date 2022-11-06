import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping/model/myOrderCustomer.dart';
import 'package:shopping/shared/compononet/MyCachedNetworkImage.dart';
import 'package:shopping/shared/compononet/orderDialog.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:sizer/sizer.dart';

class EXPTile extends StatelessWidget {
  final DataOrder order;
  final bool visable;
  final int index;
  final TextStyle _style=const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

  const EXPTile({Key? key, required this.order,required this.visable,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ExpansionTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height:visable?29.h:20.h,
                //  width: double.infinity,
                decoration: BoxDecoration(
                  color: myBlue,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            mytranslate(context, "namee"),
                            style: _style,
                          ),
                          Text(
                            "${order.userInfo!.name}",
                            style:_style,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            mytranslate(context, "q"),
                            style:_style,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .1,
                            height: MediaQuery.of(context).size.height * .03,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: Center(
                              child: Text(
                                order.many.toString(),
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            mytranslate(context, "totals"),
                            style:_style,
                          ),
                          Text(
                            order.total.toString(),
                            style: _style,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            mytranslate(context, "time"),
                            style:_style,
                          ),
                          Text(
                            mytime(order.time),
                            style: _style,
                          ),
                        ],
                      ),
                      visable?TextButton(
                        onPressed: (){
                          showDialog(
                              context: context, builder: (context) => ConfirmOrderDialog(text: order.productOrder!.title!,id: order.id!,index: index,));
                        },
                        child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.00),color: myWhite),
                            height:  5.h,
                            width: 45.w,
                            // ignore: prefer_const_constructors
                            child:Center(child: Text("Confirm Order",style: TextStyle(color: myBlue),))
                        ),
                      ):const SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          children: [
            Divider(
              height: 10,
              color: Colors.grey[900],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .3,
                        height: MediaQuery.of(context).size.height * .15,
                        child:  MyCachedNetWorkImage(logo: order.productOrder!.image!,radius: 0.0),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            order.productOrder!.title!,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: mytranslate(context, "costt"),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontSize: 12),
                                ),
                                TextSpan(
                                  text: order.productOrder!.price,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: myBlue),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    height: 10,
                    color: Colors.blue,
                  ),
                ],
              ),
            )
          ]),
    );
  }
  String mytime(title){
    DateTime now = DateTime.parse(title);
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now).toString();
    return formattedDate;
  }
}
