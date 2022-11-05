import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

import 'package:image_picker/image_picker.dart';
import 'package:shopping/modules/Customer/cubit/state.dart';
import 'package:shopping/shared/compononet/arrowBack.dart';
import 'package:shopping/shared/localization/translate.dart';

import '../../../shared/compononet/borderSignup.dart';
import '../../../shared/compononet/componotents.dart';
import '../../../shared/compononet/product_textField.dart';
import '../../../shared/my_colors.dart';
import '../../../shared/compononet/verification_dialog.dart';
import '../cubit/cubit.dart';
import '../customer_home_screen.dart';
import '../login/cubit/cubit.dart';
import '../products/cubit/cubit.dart';

class UpdateCustomer extends StatelessWidget {
  UpdateCustomer({
    Key? key,
  }) : super(key: key);
  TextEditingController phoneCustomer = TextEditingController();
  TextEditingController namerStore = TextEditingController();
  TextEditingController namerStoreEN = TextEditingController();
  TextEditingController adressCustomer = TextEditingController();
  TextEditingController passwordCustomer = TextEditingController();
  TextEditingController nameCustomer = TextEditingController();
  TextEditingController nameCustomerEN = TextEditingController();
  TextEditingController storeLocation = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var model = ProductCubit.get(context).prosCustomerModel;
    return Scaffold(
        appBar: AppBar(title: Text(mytranslate(context, "updcus")),leading: const SizedBox(),actions: [MyArrowBack(onPress: ()=>Navigator.pop(context))],),
        body: SingleChildScrollView(
            child: Form(
                key: form,
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 23, right: 23),
                        child: Column(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  mytranslate(context, "mobile"),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 15),
                                  child: MyProTextField(
                                    label: model!.data!.phone,
                                    controller: phoneCustomer,
                                    obcure: false,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'You should Fill Field!!';
                                      }
                                    },
                                  ),
                                ),
                                Text(
                                  mytranslate(context, "namestore"),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 15),
                                  child: MyProTextField(
                                    label: model.data!.titleAr,
                                    controller: namerStore,
                                    obcure: false,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'You should Fill Field!!';
                                      }
                                    },
                                  ),
                                ),
                                Text(
                                  mytranslate(context, "address"),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 15),
                                  child: MyProTextField(
                                    label: model.data!.address,
                                    controller: adressCustomer,
                                    obcure: false,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'You should Fill Field!!';
                                      }
                                    },
                                  ),
                                ),
                                Text(
                                  mytranslate(context, "loc"),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 15),
                                  child: MyProTextField(
                                    label: model.data!.longitude,
                                    controller: storeLocation,
                                    obcure: false,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'You should Fill Field!!';
                                      }
                                    },
                                  ),
                                ),
                                Text(
                                  mytranslate(context, "name"),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 15),
                                  child: MyProTextField(
                                    label: model.data!.nameAr,
                                    controller: nameCustomer,
                                    obcure: false,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'You should Fill Field!!';
                                      }
                                    },
                                  ),
                                ),
                                Text(
                                  mytranslate(context, "hintpassword"),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 15),
                                  child: MyProTextField(
                                    label: "**********",
                                    controller: passwordCustomer,
                                    obcure: false,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'You should Fill Field!!';
                                      }
                                    },
                                  ),
                                ),
                              ]),
                          BlocConsumer<CustomerCubit, CustomerStates>(
                              listener: ((context, state) {
                            if (state is CustomerUpdatingSucessState) {
                              if (model.status == true) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomDialog(
                                        btnName: mytranslate(context, "ok"),
                                        text: mytranslate(context, "upd"),
                                        onTap: () =>
                                            navigateTo(context, CustomerHome()),
                                      );
                                    });
                              }
                            }else if (state is CustomerUpdatingErrorDataState){
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialog(
                                      btnName: mytranslate(context, "ok"),
                                      text: state.error,
                                      onTap: () => Navigator.pop(context),
                                    );
                                  });
                            }else if (state is CustomerUpdatingErrorState){
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialog(
                                      btnName: mytranslate(context, "ok"),
                                      text:mytranslate(context, "error"),
                                      onTap: () => Navigator.pop(context),
                                    );
                                  });
                            }else{}
                          }), builder: (context, state) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RichText(
                                      maxLines: 1,

                                      // The number of font pixels for each logical pixel
                                      textScaleFactor: 1,
                                      text: TextSpan(
                                        text: mytranslate(context, "cato"),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  mytranslate(context, "must"),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.red)),
                                        ],
                                      ),
                                    )),

                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          CustomerCubit.get(context)
                                              .getChangeColorMen();
                                        },
                                        child: BorderSignup(
                                            color: CustomerCubit.get(context)
                                                .changeColorMen,
                                            lable: mytranslate(context, "men")),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          CustomerCubit.get(context)
                                              .getChangeColorWomen();
                                        },
                                        child: BorderSignup(
                                            color: CustomerCubit.get(context)
                                                .changeColorWomen,
                                            lable:
                                                mytranslate(context, "Women")),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          CustomerCubit.get(context)
                                              .getChangeColorBaby();
                                        },
                                        child: BorderSignup(
                                            color: CustomerCubit.get(context)
                                                .changeColorBaby,
                                            lable:
                                                mytranslate(context, "baby")),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                  width: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    mytranslate(context, "logo"),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: HexColor(
                                            '#A7B3CF'), //background color of dropdown button
                                        border: Border.all(
                                            color: HexColor('#A7B3CF'),
                                            width:
                                                0), //border of dropdown button
                                        borderRadius: BorderRadius.circular(
                                            25), //border raiuds of dropdown button
                                        boxShadow: <BoxShadow>[
                                          //apply shadow on Dropdown button
                                          BoxShadow(
                                              color: myBlue,
                                              blurRadius:
                                                  0.1), //shadow for button
                                        ]),
                                    child: InkWell(
                                      onTap: () {
                                        CustomerCubit.get(context)
                                            .getImageBloc(ImageSource.gallery);
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.image_rounded,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 30),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              mytranslate(context, "browse"),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                                ),
                                if (CustomerCubit.get(context).imagee != null)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .2,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .4,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: FileImage(
                                                CustomerCubit.get(context)
                                                    .imagee!),
                                          ))),
                                    ),
                                  ),

                                Padding(
                                  padding: const EdgeInsets.all(50.0),
                                  child: Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          .40,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .1,
                                      decoration: BoxDecoration(
                                          color: myBlue,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: MaterialButton(
                                        onPressed: () async {
                                          CustomerCubit.get(context)
                                              .updateCustomer(
                                            phone: phoneCustomer.text.isEmpty
                                                ? model.data!.phone
                                                : phoneCustomer.text,
                                            adress: adressCustomer.text.isEmpty
                                                ? model.data!.address
                                                : adressCustomer.text,
                                            nameStore: namerStore.text.isEmpty
                                                ? model.data!.titleAr
                                                : namerStore.text,
                                            nameStoreEn: namerStoreEN.text.isEmpty
                                                ? model.data!.titleEn
                                                : namerStoreEN.text,
                                            name: nameCustomer.text.isEmpty
                                                ? model.data!.nameAr
                                                : nameCustomer.text,
                                            nameEn: nameCustomerEN.text.isEmpty
                                                ? model.data!.nameEn
                                                : nameCustomerEN.text,
                                            storeLocation: storeLocation.text.isEmpty
                                                ? model.data!.longitude
                                                : storeLocation.text,
                                            context: context,
                                            pass: passwordCustomer.text.isEmpty
                                                ? null
                                                : passwordCustomer.text,
                                            img: CustomerCubit.get(context)
                                                        .imagee !=
                                                    null
                                                ? MultipartFile.fromFileSync(
                                                    CustomerCubit.get(context)
                                                        .imagee!
                                                        .path)
                                                : null,
                                          );
                                          print(storeLocation.text);
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
                          })
                        ]))))));
  }
}
