import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/modules/Customer/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/cubit/states.dart';
import 'package:shopping/modules/OrderStauts/Success.dart';
import 'package:shopping/modules/OrderStauts/failed.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/myToast.dart';
import 'package:shopping/shared/compononet/textField.dart';
import 'package:shopping/shared/compononet/verification_phone_dialog.dart';
import 'package:shopping/shared/error_compon.dart';

import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../modules/Customer/cubit/state.dart';
import 'check_phone_cart.dart';

class SignUpCartDialog extends StatelessWidget {
  String? phoneStore;
  final formKey = GlobalKey<FormState>();

  SignUpCartDialog.SignUpCartDialog({Key? key, this.phoneStore}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).getMyShared();
    return BlocConsumer<ProductCubit,ProductStates>(
      listener: (ctx,state){
        if (state is InsertOrderSucessState) {

        } else if (state is InsertOrderErrorState) {
          navigateToFinish(context, const FailedOrder());
          ProductCubit.get(context).accept = false;
        }else{

        }
      },
      builder: (ctx,state){
        final cubit = ProductCubit.get(context);
        return Scaffold(
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                margin: const EdgeInsets.only(top: 13.0, right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Center(child:  CircleAvatar(radius:80,backgroundImage:ExactAssetImage("assets/logo.png"),)),
                    Text(
                      mytranslate(context, "reg"),
                      style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                    ),
                    Divider(color: myBlack,),
                    Center(
                      child: Text(
                        CheckDialog.phoneCheckController.text,
                        style: TextStyle(
                            color: myBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    MyTextField(
                      readonly: false,
                      prefix: Icons.person_outline,
                      controller: nameController,
                      obcure: false,
                      type: TextInputType.name,
                      label: mytranslate(context, "name"),
                      validate: (value) {
                        if (value!.isEmpty) return "INVALID FIELD";
                        return null;
                      },
                    ),
                    MyTextField(
                      readonly: false,
                      prefix: Icons.email_outlined,
                      type: TextInputType.emailAddress,
                      controller: emailController,
                      obcure: false,
                      label: mytranslate(context, "email"),
                      validate:(value)  {if (value!.isEmpty) return mytranslate(context, "validateEmail");},
                    ),
                    MyTextField(
                        readonly: false,
                        controller: addressController,
                        type: TextInputType.multiline,
                        obcure: false,
                        maxline: 5,
                        label: mytranslate(context, "address"),
                        validate: (value) {
                          if (value!.isEmpty) return "INVALID FIELD";
                          return null;
                        }
                    ),
                    const SizedBox(height: 24.0),
                    Center(
                      child: InkWell(
                          onDoubleTap: (){},
                          child: Container(
                            width: MediaQuery.of(context).size.width * .5,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: myBlue,
                              borderRadius:  BorderRadius.circular(16.0),
                            ),
                            child: state is InsertOrderLoadingState ? const CircularProgressIndicator(color: Colors.white12,):Text(
                              mytranslate(context, "verify"),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            if (formKey.currentState!.validate()) {
                              await CustomerCubit.get(context).createUser(
                                  name: nameController.text,
                                  address: addressController.text,
                                  email: emailController.text,
                                  phone: CheckDialog.phoneCheckController.text)
                                  .then((value) => {
                              cubit.items.forEach((key, value) async {
                              await cubit.createOrder(size: value.size.toString(), price: value.price.toString(), many: value.quantity.toString(),
                              customerID: CustomerCubit.get(context).userId, productID: value.id.toString() );
                              }),
                              ProductCubit.get(context).accept = false
                              }).whenComplete(() => {
                              navigateToFinish(context, const SuccessOrder(phone: "06510355051",)),
                                  ProductCubit.get(context).removeCart()
                              });
                            }
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
