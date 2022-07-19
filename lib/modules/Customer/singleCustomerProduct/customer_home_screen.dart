import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopping/model/CustomerModel.dart';
import 'package:shopping/model/product.dart';
import 'package:shopping/modules/Customer/cubit/cubit.dart';
import 'package:shopping/modules/Customer/cubit/state.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/cubit/states.dart';
import 'package:shopping/modules/Customer/products/updateProduct.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

import '../products/createProduct.dart';

class CustomerHome extends StatelessWidget {
  var id;
  CustomerHome({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductCubit.get(context).getProducts(id);
    return BlocConsumer<ProductCubit, ProductStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // ProductCubit.get(context).getProducts(id);
          var productItem = ProductCubit.get(context).listProduct;
          return Scaffold(
            appBar: AppBar(actions: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.logout_rounded,
                    color: myBlue,
                  ),
                ),
              )
            ]),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: HexColor('#A7B3CF'),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            height: MediaQuery.of(context).size.height * .20,
                            width: MediaQuery.of(context).size.width * .42,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: Column(
                                children: [
                                  Text(
                                    mytranslate(context, "editdata"),
                                    style: TextStyle(
                                        color: myWhite,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 76.0),
                                    child: InkWell(
                                      onTap: () {},
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: myBlue,
                                        child: const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: HexColor('#A7B3CF'),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            height: MediaQuery.of(context).size.height * .20,
                            width: MediaQuery.of(context).size.width * .42,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 35.0),
                              child: Column(
                                children: [
                                  Text(
                                    mytranslate(context, "track"),
                                    style: TextStyle(
                                        color: myWhite,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 76.0),
                                    child: InkWell(
                                      onTap: () {},
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: myBlue,
                                        child: const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * .90,
                          height: MediaQuery.of(context).size.height * .07,
                          decoration: BoxDecoration(
                              color: myBlue,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20)),
                          child: MaterialButton(
                            onPressed: () {
                              navigateTo(
                                  context,
                                  CreatePro(
                                    id: id,
                                  ));
                            },
                            child: Text(
                              mytranslate(context, "addpro"),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text(
                              mytranslate(context, "pro"),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Spacer(),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                mytranslate(context, "more"),
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: myBlue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )),
                        ],
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return productItem.isEmpty
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                :myCard(context: context,pro: productItem[index]);
                          },
                          itemCount: productItem.length)
                    ]),
              ),
            ),
          );
        });
  }
  Widget myCard({context,required ProductItemMainCustomer pro}){
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white, //background color of dropdown button
            border: Border.all(color: HexColor('#A7B3CF'), width:
            1), //border of dropdown button
            borderRadius:
            BorderRadius.circular(20),
          ),
          child: Column(children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.start,
              crossAxisAlignment:
              CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0, bottom: 15),
                  child: Container(
                    width: MediaQuery.of(context)
                        .size
                        .width *
                        .33,
                    height: MediaQuery.of(context)
                        .size
                        .height *
                        .10,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(
                          10),
                      image: DecorationImage(
                        image: NetworkImage(pro.images![0].logo!),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(
                          bottom: 8.0),
                      child: Text(pro.titleAr!,
                          style: TextStyle(
                            color: HexColor(
                                '#A7B3CF'),
                            fontSize: 18,
                            fontWeight:
                            FontWeight.bold,
                          )),
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text:pro.price!,
                              style: const TextStyle(
                                  color: Colors
                                      .black87,
                                  fontSize: 14,
                                  fontWeight:
                                  FontWeight
                                      .bold)),
                          TextSpan(
                              text: "WD",
                              style: TextStyle(
                                  color: Colors
                                      .grey[400],
                                  fontSize: 14,
                                  fontWeight:
                                  FontWeight
                                      .bold)),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            Container(
              color: HexColor('#A7B3CF'),
              height: 1,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 20),
                  child: Text(
                      "${pro.many!}  ${mytranslate(context, "pic")}",
                      style: const TextStyle(
                          color: Colors.black54,
                          fontWeight:
                          FontWeight.bold)),
                ),
                Spacer(),
                TextButton(
                    onPressed: () async{
                      await ProductCubit.get(context).showPro(id, context).then((value) {
                        print(value.toString());
                        navigateTo(context, UpdateProduct(id:pro.id!));
                      });
                      },
                    child: Text(
                      "Edit Product",
                      style: TextStyle(decoration: TextDecoration.underline, color: myBlue, fontWeight: FontWeight.bold,fontSize: 14),
                    )),
              ],
            ),

            //  Text(cubit.list[index].)
          ]),
        ),
        const SizedBox(height: 20,)
      ],
    );
  }
}
