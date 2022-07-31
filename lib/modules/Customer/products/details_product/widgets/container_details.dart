import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shopping/modules/Customer/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/details_product/widgets/counter.dart';
import 'package:shopping/shared/compononet/myToast.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

import '../../../../../shared/compononet/componotents.dart';
import '../../../../cart/cart.dart';

class CustomContainerDetails extends StatelessWidget {
  String? image;
  String? name;
  dynamic rating;
  dynamic price;
  String? desc;
  int? many;
  var id;
  CustomContainerDetails(
      {this.image,
      this.name,
      this.rating,
      this.price,
      this.desc,
      this.many,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50.0),
          topLeft: Radius.circular(50.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  name.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      wordSpacing: 3,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "48Rates",
                        style: TextStyle(color: Colors.black),
                      ),
                      const Spacer(),
                      RatingBar.builder(
                        itemSize: 20,
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
                    ]),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                desc!,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
                maxLines: 3,
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(mytranslate(context, "price"),
                        style: const TextStyle(
                            color: Colors.black,
                            wordSpacing: 3,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Text(mytranslate(context, "amu"),
                        style: const TextStyle(
                            color: Colors.black,
                            wordSpacing: 3,
                            fontSize: 15,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              Row(children: [
                Text(
                  ' ${price.toString()}  ',
                  style: const TextStyle(
                      color: Colors.black,
                      wordSpacing: 3,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomHorizCounterContainer(
                      counter: ProductCubit.get(context).itemCount,
                      upward: () {
                        if (ProductCubit.get(context).itemCount <= many!) {
                          ProductCubit.get(context).plus();
                        } else {
                          myToast(message: mytranslate(context, "exc"));
                        }
                      },
                      downrd: () {
                        if (ProductCubit.get(context).itemCount > 1) {
                          ProductCubit.get(context).minuss();
                        } else {
                          myToast(message: mytranslate(context, "nott"));
                        }
                      },
                    ))
              ]),
              const SizedBox(
                height: 30,
              ),
              Row(children: [
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color:
                            Colors.white, //background color of dropdown button
                        border: Border.all(
                            color: myBlue,
                            width: 2), //border of dropdown button
                        borderRadius: BorderRadius.circular(
                            10), //border raiuds of dropdown button
                        boxShadow: <BoxShadow>[
                          //apply shadow on Dropdown button
                          BoxShadow(
                              color: myBlue,
                              blurRadius: 0.1), //shadow for button
                        ]),
                    child: DropdownButton(
                      focusColor: myBlue,
                      isExpanded: true,
                      underline: const SizedBox(),
                      elevation: 1,
                      hint: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: ProductCubit.get(context).selectSize == null
                                ? Text(
                                    mytranslate(context, "sizes"),
                                    style: TextStyle(
                                        color: myBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                : Text(
                                    ProductCubit.get(context).selectSize!,
                                    style: TextStyle(
                                        color: myBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )),
                      ),

                      // value: cubit.catSelect??,
                      icon: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: myBlue,
                        size: 35,
                      ),
                      items: ProductCubit.get(context)
                          .sizes
                          .map<DropdownMenuItem<String>>(
                              (size) => DropdownMenuItem(
                                    value: size,
                                    child: Center(
                                      child: Text(size),
                                    ),
                                  ))
                          .toList(),
                      onChanged: (val) {
                        ProductCubit.get(context).changeSize(val);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .6,
                  height: MediaQuery.of(context).size.height * .06,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: myBlue,
                    onPressed: () {
                      ProductCubit.get(context).additem(
                          proid: id.toString(),
                          imgurl: image.toString(),
                          title: name.toString(),
                          price: double.parse(price),
                          qua: ProductCubit.get(context).itemCount);
                      myToast(message: "$name Is Added ");
                    },
                    child: Text(
                      mytranslate(context, "order"),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ]),
              // const SizedBox(
              //   height: 1,
              // )

              // Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
