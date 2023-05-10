import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myshoop/Cubit/cubit.dart';
import 'package:myshoop/modules/Customer/cubit/cubit.dart';
import 'package:myshoop/modules/Customer/products/cubit/cubit.dart';
import 'package:myshoop/modules/Customer/products/cubit/states.dart';
import 'package:myshoop/modules/OrderStauts/Success.dart';
import 'package:myshoop/modules/OrderStauts/failed.dart';
import 'package:myshoop/modules/cart/widget/floatingOrder.dart';
import 'package:myshoop/modules/payment/cubit/cubit.dart';
import 'package:myshoop/modules/payment/cubit/state.dart';
import 'package:myshoop/modules/payment/payment.dart';
import 'package:myshoop/shared/compononet/componotents.dart';
import 'package:myshoop/shared/compononet/myToast.dart';
import 'package:myshoop/shared/compononet/textField.dart';
import 'package:myshoop/shared/compononet/verification_phone_dialog.dart';
import 'package:myshoop/shared/error_compon.dart';

import 'package:myshoop/shared/localization/translate.dart';
import 'package:myshoop/shared/my_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../modules/Customer/cubit/state.dart';
import 'check_phone_cart.dart';

class SignUpCartDialog extends StatelessWidget {
  String? phoneStore;
  final amout;
  final formKey = GlobalKey<FormState>();
  SignUpCartDialog.SignUpCartDialog({Key? key, this.phoneStore,this.amout}) : super(key: key);
  static TextEditingController lastNameController = TextEditingController();
  static TextEditingController firstNameController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController addressController = TextEditingController();
  static TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).getMyShared();
    return BlocBuilder<PaymentCubit,PaymentStates>(
      builder: (ctx,state){
        final cubit = PaymentCubit.get(context);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          child: MyTextField(
                            readonly: false,
                            prefix: Icons.person_outline,
                            controller: firstNameController,
                            obcure: false,
                            type: TextInputType.name,
                            label: mytranslate(context, "name"),
                            validate: (value) {
                              if (value!.isEmpty) return "INVALID FIELD";
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: MyTextField(
                            readonly: false,
                            prefix: Icons.person_outline,
                            controller: lastNameController,
                            obcure: false,
                            type: TextInputType.name,
                            label: mytranslate(context, "lname"),
                            validate: (value) {
                              if (value!.isEmpty) return "INVALID FIELD";
                              return null;
                            },
                          ),
                        ),
                      ],
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
                            child: state is PaymentLoading ? const CircularProgressIndicator(color: Colors.white12,):Text(
                              mytranslate(context, "verify"),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (formKey.currentState!.validate()) {
                                cubit.getLink(lastName:lastNameController.text,address: addressController.text,phone: CheckDialog.phoneCheckController.text,
                                    email: emailController.text,amount:MyFloating.result.toString(),firstName: firstNameController.text).then((value) => {
                                navigateTo(context, Payment(url: "${cubit.url}",code: "${cubit.codeTran}",))
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
