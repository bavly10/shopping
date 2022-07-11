import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/shared/compononet/describe_text_feild.dart';
import 'package:shopping/shared/compononet/product_textField.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

import '../../../../Cubit/states.dart';

class CreateProduct extends StatelessWidget {
  CreateProduct({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameProduct = TextEditingController();
    TextEditingController typeProduct = TextEditingController();
    TextEditingController priceProduct = TextEditingController();
    TextEditingController amountProduct = TextEditingController();
    TextEditingController describeProduct = TextEditingController();

    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (ctx, state) {},
        builder: (ctx, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Text(
                  mytranslate(
                    context,
                    "addpro",
                  ),
                  style: const TextStyle(fontSize: 18),
                )),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mytranslate(context, "namepro"),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          MyProTextField(
                            controller: nameProduct,
                            obcure: false,
                            label: "",
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'You should Fill Field!!';
                              }
                            },
                          ),
                          Text(
                            mytranslate(context, "typepro"),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          MyProTextField(
                            controller: typeProduct,
                            obcure: false,
                            label: "",
                            validate: (value) {
                              if (value!.isEmpty)
                                return 'You should Fill Field!!';
                            },
                          ),
                          Text(
                            mytranslate(context, "price"),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          MyProTextField(
                            controller: priceProduct,
                            obcure: false,
                            label: "",
                            validate: (value) {
                              if (value!.isEmpty)
                                return 'You should Fill Field!!';
                            },
                          ),
                          Text(
                            mytranslate(context, "amount"),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          MyProTextField(
                            controller: amountProduct,
                            obcure: false,
                            label: "",
                            validate: (value) {
                              if (value!.isEmpty)
                                return 'You should Fill Field!!';
                            },
                          ),
                          Text(
                            mytranslate(context, "describe"),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .17,
                            width: MediaQuery.of(context).size.width,
                            child: MyDescribeTextField(
                                controller: describeProduct,
                                label: "",
                                maxline: 10,
                                validate: (value) {
                                  if (value!.isEmpty)
                                    return 'You should Fill Field!!';
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              mytranslate(context, "size"),
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Wrap(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "S",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Checkbox(
                                  value: cubit.s,
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
                                  value: cubit.m,
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
                                  value: cubit.l,
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
                                  value: cubit.xl,
                                  onChanged: (value) {
                                    cubit.changexlChecked(value!);
                                  },
                                  activeColor: myBlue),
                              const SizedBox(
                                width: 3,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "2XL",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Checkbox(
                                  value: cubit.two_xl,
                                  onChanged: (value) {
                                    ShopCubit.get(context)
                                        .changetwoXlChecked(value!);
                                  },
                                  activeColor: myBlue),
                              const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "3XL",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Checkbox(
                                  value: cubit.three_xl,
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
                                  value: cubit.four_xl,
                                  onChanged: (value) {
                                    cubit.change4XlChecked(value!);
                                  },
                                  activeColor: myBlue),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              mytranslate(context, "imagepro"),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              cubit.imageFileList.isNotEmpty
                                  ? SizedBox(
                                      height: 150,
                                      width: MediaQuery.of(context).size.width,
                                      child: CarouselSlider.builder(
                                        options: CarouselOptions(),
                                        itemCount: cubit.imageFileList.length,
                                        itemBuilder: (BuildContext context,
                                                int itemIndex,
                                                int pageViewIndex) =>
                                            Container(
                                                child: Image.file(File(cubit
                                                    .imageFileList[itemIndex]
                                                    .path))),
                                      ),
                                    )
                                  : Text(
                                      'No element  Selected Yet',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[400]),
                                    ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .40,
                                  height:
                                      MediaQuery.of(context).size.height * .06,
                                  decoration: BoxDecoration(
                                      color: myBlue,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: MaterialButton(
                                    onPressed: () async {
                                      cubit.selectImages();
                                    },
                                    child: const Text('choose images',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        )),
                                  ),
                                ),
                              ),
                            ],
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
                                    for (var x
                                        in ShopCubit.get(context).imageFileList) {
                                      y.add(MultipartFile.fromFileSync(x.path));
                                    }
                                    if (formKey.currentState!.validate()) {
                                      cubit.createProducts(
                                        userid: 8,
                                        categoryId: 10,
                                        price: priceProduct.text,
                                        many: amountProduct.text,
                                        s: cubit.s,
                                        m: cubit.m,
                                        l: cubit.l,
                                        xl: cubit.xl,
                                        twoXl: cubit.two_xl,
                                        threexl: cubit.three_xl,
                                        fourxl: cubit.four_xl,
                                        img: y,
                                        descAr: describeProduct.text,
                                        descEn: describeProduct.text,
                                        tittleAr: nameProduct.text,
                                        tittleEn: nameProduct.text,
                                      );
                                    }
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
                          )
                        ]),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
