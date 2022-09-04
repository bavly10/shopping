import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopping/model/myOrderCustomer.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

class EXPTile extends StatelessWidget {
  final DataOrder order;
  const EXPTile({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ExpansionTile(
          title: Container(
            height: MediaQuery.of(context).size.height * .05,
            //  width: double.infinity,
            decoration: BoxDecoration(
              color: myBlue,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Name:",
                    style:  TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "${order.userInfo!.name}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          mytranslate(context, "q"),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
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
                                color: Colors.red, fontWeight: FontWeight.bold,fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          subtitle: Row(
            children: [
              Text(
                order.total.toString(),
                style: TextStyle(
                    color: myBlack, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                mytranslate(context, "tot"),
                style:  TextStyle(
                    color: myBlack, fontWeight: FontWeight.bold),
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
                      Container(
                        width: MediaQuery.of(context).size.width * .1,
                        height: MediaQuery.of(context).size.height * .1,
                        child: Image.network(order.productOrder!.image!),
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
}
