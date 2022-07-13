import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/model/categoryModel.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/cubit/states.dart';
import 'package:shopping/shared/compononet/describe_text_feild.dart';
import 'package:shopping/shared/compononet/product_textField.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

class CreatePro extends StatelessWidget {
  CreatePro({Key? key}) : super(key: key);
  TextEditingController nameProduct = TextEditingController();
  TextEditingController typeProduct = TextEditingController();
  TextEditingController priceProduct = TextEditingController();
  TextEditingController amountProduct = TextEditingController();
  TextEditingController describeProduct = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mytranslate(context, "addpro")),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: form,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 23, right: 23),
              child: Column(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          mytranslate(context, "namepro"),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 15),
                          child: MyProTextField(
                            controller: nameProduct,
                            obcure: false,
                            label: "",
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'You should Fill Field!!';
                              }
                            },
                          ),
                        ),
                        Text(
                          mytranslate(context, "price"),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 15),
                          child: MyProTextField(
                            controller: priceProduct,
                            obcure: false,
                            label: "",
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'You should Fill Field!!';
                              }
                            },
                          ),
                        ),
                        Text(
                          mytranslate(context, "amount"),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 15),
                          child: MyProTextField(
                            controller: amountProduct,
                            obcure: false,
                            label: "",
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'You should Fill Field!!';
                              }
                            },
                          ),
                        ),
                        Text(
                          mytranslate(context, "describe"),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .17,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 15),
                            child: MyDescribeTextField(
                                controller: describeProduct,
                                label: "",
                                maxline: 10,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'You should Fill Field!!';
                                  }
                                }),
                          ),
                        ),
                      ]),
                  BlocBuilder<ProductCubit, ProductStates>(
                    builder: (context, state) {
                      final cubit = ProductCubit.get(context);
                      final list = ShopCubit.get(context).categoryModel;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              mytranslate(context, "size"),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 20, right: 30),
                            child: Wrap(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "S",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Checkbox(
                                    value: cubit.sm,
                                    onChanged: (value) {
                                      cubit.changeSChecked(value!);
                                    },
                                    activeColor: myBlue),
                                const SizedBox(
                                  width: 3,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "M",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Checkbox(
                                    value: cubit.me,
                                    onChanged: (value) {
                                      cubit.changetwoMChecked(value!);
                                    },
                                    activeColor: myBlue),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "L",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Checkbox(
                                    value: cubit.la,
                                    onChanged: (value) {
                                      cubit.changelChecked(value!);
                                    },
                                    activeColor: myBlue),
                                const SizedBox(
                                  width: 3,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "XL",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Checkbox(
                                    value: cubit.xla,
                                    onChanged: (value) {
                                      cubit.changexlChecked(value!);
                                    },
                                    activeColor: myBlue),
                                const SizedBox(
                                  width: 3,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                    top: 8.0,
                                  ),
                                  child: Text(
                                    "2XL",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Checkbox(
                                    value: cubit.two_xlla,
                                    onChanged: (value) {
                                      ProductCubit.get(context)
                                          .changetwoXlChecked(value!);
                                    },
                                    activeColor: myBlue),
                                const Padding(
                                  padding: EdgeInsets.only(
                                    top: 8.0,
                                  ),
                                  child: Text(
                                    "3XL",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Checkbox(
                                    value: cubit.three_xlla,
                                    // value: cubit.three_xll,
                                    onChanged: (value) {
                                      cubit.changeThreeXlChecked(value!);
                                    },
                                    activeColor: myBlue),
                                const SizedBox(
                                  width: 3,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "4XL",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Checkbox(
                                    value: cubit.four_xlla,
                                    onChanged: (value) {
                                      cubit.change4XlChecked(value!);
                                    },
                                    activeColor: myBlue),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              mytranslate(context, "typepro"),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 12.0, bottom: 15),
                            child: Row(
                              children: [
                                Text(
                                  mytranslate(context, "type"),
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: Colors
                                            .white, //background color of dropdown button
                                        border: Border.all(
                                            color: myGrey!,
                                            width:
                                                3), //border of dropdown button
                                        borderRadius: BorderRadius.circular(
                                            30), //border raiuds of dropdown button
                                        boxShadow: <BoxShadow>[
                                          //apply shadow on Dropdown button
                                          BoxShadow(
                                              color: myBlue,
                                              blurRadius:
                                                  0.1), //shadow for button
                                        ]),
                                    child: DropdownButton(
                                      focusColor: myBlue,

                                      isExpanded: true,
                                      underline: const SizedBox(),
                                      elevation: 2,
                                      hint: cubit.catSelect == null
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Text(
                                                  mytranslate(
                                                      context, "service"),
                                                  style: TextStyle(
                                                      color: myBlue,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Center(
                                                child: Text(cubit.catSelect!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: myBlue,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                      // value: cubit.catSelect??,
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        color: myBlue,
                                        size: 35,
                                      ),
                                      items: list!.data!
                                          .map<DropdownMenuItem<CatItem>>(
                                              (cat) => DropdownMenuItem(
                                                    value: cat,
                                                    child: Center(
                                                      child: Text(cat.title!),
                                                    ),
                                                  ))
                                          .toList(),
                                      onChanged: (val) {
                                        cubit.changeSelectCategory(val);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              mytranslate(context, "imagepro"),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors
                                    .white, //background color of dropdown button
                                border: Border.all(
                                    color: myGrey!,
                                    width: 3), //border of dropdown button
                                borderRadius: BorderRadius.circular(
                                    30), //border raiuds of dropdown button
                                boxShadow: <BoxShadow>[
                                  //apply shadow on Dropdown button
                                  BoxShadow(
                                      color: myBlue,
                                      blurRadius: 0.1), //shadow for button
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  cubit.imageFileList.isNotEmpty
                                      ? SizedBox(
                                          height: 150,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: CarouselSlider.builder(
                                            options:
                                                CarouselOptions(autoPlay: true),
                                            itemCount:
                                                cubit.imageFileList.length,
                                            itemBuilder: (BuildContext context,
                                                    int itemIndex,
                                                    int pageViewIndex) =>
                                                Container(
                                                    child: Image.file(File(cubit
                                                        .imageFileList[
                                                            itemIndex]
                                                        .path))),
                                          ),
                                        )
                                      : Center(
                                          child: Text(
                                            mytranslate(context, "yet"),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[400]),
                                          ),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          .40,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .06,
                                      decoration: BoxDecoration(
                                          color: myBlue,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: MaterialButton(
                                        onPressed: () async {
                                          cubit.selectImages(context);
                                        },
                                        child:
                                            Text(mytranslate(context, "select"),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                )),
                                      ),
                                    ),
                                  ),
                                  Text(
                                      "${mytranslate(context, "choose")}${cubit.imageFileList.length}  ${mytranslate(context, "images")}")
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * .40,
                                height: MediaQuery.of(context).size.height * .1,
                                decoration: BoxDecoration(
                                    color: myBlue,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(20)),
                                child: MaterialButton(
                                  onPressed: () async {
                                    print(typeProduct.text.toString());
                                    List y = [];
                                    for (var x in ProductCubit.get(context)
                                        .imageFileList) {
                                      y.add(MultipartFile.fromFileSync(x.path));
                                    }
                                    cubit.create(
                                      userid: 8,
                                      price: priceProduct.text,
                                      descAr: describeProduct.text,
                                      descEn: "dawdwa",
                                      many: amountProduct.text,
                                      tittleAr: nameProduct.text,
                                      tittleEn: "dwadwad",
                                      img: y,
                                    );
                                  },
                                  child: Text(
                                    mytranslate(context, "save"),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
