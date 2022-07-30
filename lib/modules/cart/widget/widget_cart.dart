import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/shared/localization/translate.dart';

import '../../../shared/compononet/myToast.dart';
import '../../../shared/my_colors.dart';

class Cartitemapp extends StatelessWidget {
  final String id, proid, title, imgurl;
  final int quant;
  final double price;
  const Cartitemapp(
      {required this.id,
      required this.proid,
      required this.title,
      required this.imgurl,
      required this.quant,
      required this.price});
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
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 100,
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
                            const SizedBox(
                              width: 150,
                            ),
                            InkWell(
                              onTap: () {
                                ProductCubit.get(context)
                                    .removesingleitem(proid);
                              },
                              child: Icon(
                                Icons.cancel_sharp,
                                color: myBlue,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RatingBar.builder(
                                itemSize: 13,
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: myBlue,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "150 Rate",
                                  style: TextStyle(color: Colors.black45),
                                ),
                              )
                            ],
                          ),
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
                                width: 21,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 120,
                                height: 35,
                                decoration: BoxDecoration(
                                    border: Border.all(color: myBlue),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  // mainAxisAlignment: MainAxisAlignment.center,
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
                                            qua: quant);
                                      },
                                    )),
                                    Text(
                                      quant.toString(),
                                      style: TextStyle(
                                        color: myBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        child: Icon(
                                          Icons.minimize,
                                          size: 22,
                                          color: myBlue,
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

class $price {}
