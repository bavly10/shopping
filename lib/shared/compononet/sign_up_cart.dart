import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/modules/Customer/cubit/cubit.dart';
import 'package:shopping/shared/compononet/myToast.dart';
import 'package:shopping/shared/compononet/textField.dart';
import 'package:shopping/shared/compononet/verification_phone_dialog.dart';
import 'package:shopping/shared/error_compon.dart';

import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'check_phone_cart.dart';

// ignore: must_be_immutable
class SignupCartDialog extends StatelessWidget {
  Function() onTaps;
  String? phoneStore;
  final formKey = GlobalKey<FormState>();

  SignupCartDialog({Key? key, required this.onTaps, this.phoneStore})
      : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).getMyShared();
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
              top: 18.0,
            ),
            margin: const EdgeInsets.only(top: 13.0, right: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  mytranslate(context, "reg"),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(text: CheckDialog.phoneCheckController.text),
                        const WidgetSpan(
                            child: SizedBox(
                          width: 10,
                        )),
                        WidgetSpan(
                          child: Text(
                            mytranslate(context, "no"),
                            style: TextStyle(
                                color: myBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                    // textAlign: TextAlign,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow[900]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0, top: 12),
                  child: MyTextField(
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
                ),
                MyTextField(
                  prefix: Icons.email_outlined,
                  type: TextInputType.emailAddress,
                  controller: emailController,
                  obcure: false,
                  label: mytranslate(context, "email"),
                    validate:(value) => value!.isEmpty ?mytranslate(context, "validateEmail") :validateEmail(value)
                ),
                MyTextField(
                  prefix: MdiIcons.city,
                  controller: addressController,
                  type: TextInputType.streetAddress,
                  obcure: false,
                  label: mytranslate(context, "address"),
                 validate: (value) {
                   if (value!.isEmpty) return "INVALID FIELD";
                   return null;
                 }
                ),
                const SizedBox(height: 24.0),
                InkWell(
                  onDoubleTap: (){},
                    child: Container(
                      width: MediaQuery.of(context).size.width * .5,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: myBlue,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                            bottomLeft: Radius.circular(16.0),
                            bottomRight: Radius.circular(16.0)),
                      ),
                      child: Text(
                        mytranslate(context, "verify"),
                        style: const TextStyle(
                            color: Colors.white, fontSize: 25.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      if (formKey.currentState!.validate()) {
                        await CustomerCubit.get(context)
                            .createUser(
                                name: nameController.text,
                                address: addressController.text,
                                email: emailController.text,
                                phone: CheckDialog.phoneCheckController.text)
                            .then((value) => onTaps());
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
