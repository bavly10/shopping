import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/model/categoryModel.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/cubit/states.dart';
import 'package:shopping/modules/Customer/customer_home_screen.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/describe_text_feild.dart';
import 'package:shopping/shared/compononet/product_textField.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:shopping/shared/network.dart';
import 'package:shopping/shared/compononet/verification_dialog.dart';

class UpdateProduct extends StatelessWidget {
  TextEditingController nameProduct = TextEditingController();
  TextEditingController typeProduct = TextEditingController();
  TextEditingController priceProduct = TextEditingController();
  TextEditingController amountProduct = TextEditingController();
  TextEditingController describeProduct = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final model = ProductCubit.get(context).showProd!;
    final list = ShopCubit.get(context).categoryModel;
    final cubit = ProductCubit.get(context);
    var listimage = model.data!.images!;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: (() {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomDialog(
                            text: mytranslate(context, "verifydel"),
                            onTap: () => ProductCubit.get(context).deletePro(
                                id: model.data!.productData!.id,
                                context: context),
                          ));
                }),
                child: Icon(Icons.delete, color: myBlue)),
          )
        ],
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
                            label: model.data!.productData!.titleAr!,
                            controller: nameProduct,
                            obcure: false,
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
                            label: model.data!.productData!.price!,
                            controller: priceProduct,
                            obcure: false,
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
                            label: model.data!.productData!.many!,
                            controller: amountProduct,
                            obcure: false,
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
                                label: model.data!.productData!.descAr!,
                                maxline: 10,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'You should Fill Field!!';
                                  }
                                }),
                          ),
                        ),
                      ]),
                  BlocConsumer<ProductCubit, ProductStates>(
                      listener: (context, state) {
                    if (state is UpdatingSueccs) {
                      if (model.status == true) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDialog(
                                btnName: mytranslate(context, "ok"),
                                text: mytranslate(context, "upd"),
                                onTap: () =>
                                    navigateTo(context, CustomerHome().build(context)),
                              );
                            });
                      }
                    } else if (state is DeletingImageProduct) {
                      navigateToFinish(context, CustomerHome().build(context));
                    } else {}
                  }, builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                mytranslate(context, "size"),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ],
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
                                    print(value);
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
                                    print(value);
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
                          padding: const EdgeInsets.only(top: 12.0, bottom: 15),
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
                                          width: 3), //border of dropdown button
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                mytranslate(context, "service"),
                                                style: TextStyle(
                                                    color: myBlue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(4.0),
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
                                model.data!.images!.isNotEmpty
                                    ? SizedBox(
                                        height: 150,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent: 200,
                                                    childAspectRatio: 3 / 2,
                                                    crossAxisSpacing: 20,
                                                    mainAxisSpacing: 20),
                                            itemCount: listimage.length,
                                            itemBuilder:
                                                (BuildContext ctx, index) {
                                              return Stack(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color: myGrey,
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  model
                                                                      .data!
                                                                      .images![
                                                                          index]
                                                                      .logo!))),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        if (model.data!.images!
                                                                .length ==
                                                            1) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  SnackBar(
                                                            content: Text(
                                                              mytranslate(
                                                                  context,
                                                                  "last"),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        3000),
                                                          ));
                                                        } else {
                                                          showDialog(
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  CustomDialog(
                                                                      text: mytranslate(
                                                                          context,
                                                                          "verifydel"),
                                                                      onTap:
                                                                          () {
                                                                        ProductCubit.get(context)
                                                                            .deleteImage(
                                                                                id: model.data!.images![index].id!,
                                                                                context: context)
                                                                            .then((value) {
                                                                          ProductCubit.get(context)
                                                                              .showPro(model.data!.productData!.id, context)
                                                                              .then((value) {
                                                                            Navigator.pop(context,
                                                                                true);
                                                                          });
                                                                        });
                                                                      }));
                                                        }
                                                      },
                                                      child: CircleAvatar(
                                                        radius: 10,
                                                        backgroundColor: myGrey,
                                                        child: const Icon(
                                                            Icons.cancel),
                                                      ),
                                                    )
                                                  ]);
                                            }),
                                      )
                                    : Center(
                                        child: Text(
                                          mytranslate(context, "delete"),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[400]),
                                        ),
                                      ),
                                cubit.imageFileList.isNotEmpty
                                    ? SizedBox(
                                        height: 150,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: CarouselSlider.builder(
                                          options:
                                              CarouselOptions(autoPlay: true),
                                          itemCount: cubit.imageFileList.length,
                                          itemBuilder: (BuildContext context,
                                                  int itemIndex,
                                                  int pageViewIndex) =>
                                              Container(
                                                  child: Image.file(File(cubit
                                                      .imageFileList[itemIndex]
                                                      .path))),
                                        ))
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
                                    width:
                                        MediaQuery.of(context).size.width * .40,
                                    height: MediaQuery.of(context).size.height *
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
                              decoration: BoxDecoration(color: myBlue, shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(20)),
                              child: MaterialButton(
                                onPressed: () async {
                                  print(typeProduct.text.toString());
                                  List y = [];
                                  for (var x in ProductCubit.get(context).imageFileList) {
                                    y.add(MultipartFile.fromFileSync(x.path));
                                  }
                                  if (cubit.cat_id == null) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CustomDialog(
                                            btnName: mytranslate(context, "ok"),
                                            onTap: () => Navigator.pop(context),
                                            text: mytranslate(context, "cat"),
                                          );
                                        });
                                  } else {
                                    cubit.update(
                                      context: context,
                                      price: priceProduct.text.isEmpty
                                          ? model.data!.productData!.price
                                          : priceProduct.text,
                                      descAr: describeProduct.text.isEmpty
                                          ? model.data!.productData!.descAr
                                          : describeProduct.text,
                                      descEn: describeProduct.text.isEmpty
                                          ? model.data!.productData!.descAr
                                          : describeProduct.text,
                                      many: amountProduct.text.isEmpty
                                          ? model.data!.productData!.many
                                          : amountProduct.text,
                                      tittleAr: nameProduct.text.isEmpty
                                          ? model.data!.productData!.titleAr
                                          : nameProduct.text,
                                      tittleEn: "dwadwad",
                                      id: model.data!.productData!.id,
                                      img: y.isEmpty ? model.data!.images : y,
                                    );
                                    cubit.catSelect=null;
                                    cubit.cat_id=null;
                                  }
                                },
                                child: Text(
                                  mytranslate(context, "update"),
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
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
