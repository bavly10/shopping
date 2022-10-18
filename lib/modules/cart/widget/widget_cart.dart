import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/shared/localization/translate.dart';

import '../../../shared/my_colors.dart';

class Cartitemapp extends StatelessWidget {
  final String id, proid, title, imgurl, size;
  String? rate;
  final int quant;
  final double price;
  Cartitemapp(
      {required this.id,
      required this.proid,
      required this.title,
      required this.imgurl,
      required this.size,
      required this.quant,
      required this.price,
      this.rate});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Card(
          elevation: 0,
          color: myGrey,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Padding(
              padding: const EdgeInsets.only(
                bottom: 5,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, right: 5),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          ProductCubit.get(context).removeitem(proid);
                        },
                        child: Icon(
                          Icons.cancel_sharp,
                          color: myBlue,
                        ),
                      ),
                    ),
                  ),
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .14,
                        width: MediaQuery.of(context).size.width * .16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(imgurl),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                title,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .30,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${mytranslate(context, "pricee")} $price",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                    fontSize: 15),
                              ),
                              const SizedBox(
                                width: 43,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * .29,
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                decoration: BoxDecoration(
                                    border: Border.all(color: myBlue),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: InkWell(
                                      child: Icon(
                                        Icons.add,
                                        size: 22,
                                        color: myBlue,
                                      ),
                                      onTap: () {
                                        ProductCubit.get(context).additem(
                                            proid: proid,
                                            imgurl: imgurl,
                                            title: title,
                                            price: price,
                                            size: size,
                                            qua: quant);
                                      },
                                    )),
                                    Text(
                                      quant.toString(),
                                      style: TextStyle(
                                        color: myBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 25.0),
                                          child: Icon(
                                            Icons.minimize,
                                            size: 22,
                                            color: myBlue,
                                          ),
                                        ),
                                        onTap: () {
                                          ProductCubit.get(context)
                                              .removesingleitem(proid);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${mytranslate(context, "totals")} ${price * quant}",
                    style: const TextStyle(
                        color: Colors.lightBlue, fontWeight: FontWeight.bold),
                  )
                ],
              )),
        ),
      ],
    );
  }
}
