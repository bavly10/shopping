import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/shared/compononet/describe_text_feild.dart';
import 'package:shopping/shared/compononet/product_textField.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

class CreateProduct extends StatelessWidget {
  const CreateProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w;
    var nameProduct = TextEditingController();
    var typeProduct = TextEditingController();
    var priceProduct = TextEditingController();
    var amountProduct = TextEditingController();
    var describeProduct = TextEditingController();
    var formKey = GlobalKey<FormState>();
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
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  mytranslate(context, "namepro"),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyProTextField(
                  controller: nameProduct,
                  obcure: false,
                  label: "",
                  validate: (value) {
                    if (value!.isEmpty) return 'You should Fill Field!!';
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  mytranslate(context, "typepro"),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyProTextField(
                  controller: typeProduct,
                  obcure: false,
                  label: "",
                  validate: (value) {
                    if (value!.isEmpty) return 'You should Fill Field!!';
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  mytranslate(context, "price"),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyProTextField(
                  controller: priceProduct,
                  obcure: false,
                  label: "",
                  validate: (value) {
                    if (value!.isEmpty) return 'You should Fill Field!!';
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  mytranslate(context, "amount"),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyProTextField(
                  controller: amountProduct,
                  obcure: false,
                  label: "",
                  validate: (value) {
                    if (value!.isEmpty) return 'You should Fill Field!!';
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  mytranslate(context, "describe"),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .17,
                  width: MediaQuery.of(context).size.width,
                  child: MyDescribeTextField(
                    controller: describeProduct,
                    label: "",
                    maxline: 10,
                    validate: (value) {
                      if (value!.isEmpty) return 'You should Fill Field!!';
                    },
                  ),
                ),
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
                        ShopCubit.get(context).changetwoXlChecked(value!);
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
              // GridView(
              //     physics: NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //     ),
              // children: [
              Stack(alignment: Alignment.bottomRight, children: [
                InkWell(
                  onTap: (() {
                    ShopCubit.get(context).selectImages();
                  }),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: myBlue,
                    child: const Icon(Icons.add),
                  ),
                ),
                // ],
                // ),
              ]),

              /*  GridView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 1 / 1,
                      maxCrossAxisExtent: 190,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 30),
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: HexColor('#707070'),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20)),
                          child: ShopCubit.get(context).imagee != null
                              ? Image(
                                  image:
                                      FileImage(ShopCubit.get(context).imagee!))
                              : const Text('No Image'),
                        ),
                        InkWell(
                          onTap: (() {
                            ShopCubit.get(context)
                                .getImageBloc(ImageSource.gallery);
                          }),
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: myBlue,
                            child: const Icon(Icons.add),
                          ),
                        )
                      ],
                    );
                  }),*/
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
                      onPressed: () async{
                        List y=[];
                        for (var x in ShopCubit.get(context).imageFileList){
                         y.add(MultipartFile.fromFileSync(x.path));
                        }
                        cubit.create(y);
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
    );
  }
}