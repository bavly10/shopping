import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shopping/shared/compononet/textField.dart';

import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

class SignupDialog extends StatelessWidget {
  void Function()? onTap;
  String? text;
  String? btnName;
  SignupDialog({Key? key, this.onTap, this.text, this.btnName})
      : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * .69,
            width: MediaQuery.of(context).size.width * .99,
            padding: const EdgeInsets.only(
              top: 18.0,
            ),
            margin: const EdgeInsets.only(top: 13.0, right: 8.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "you are not registered\nPlease enter your data",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0, top: 12),
                    child: MyTextField(
                        prefix: Icons.person_outline,
                        controller: nameController,
                        obcure: false,
                        label: mytranslate(context, "name")),
                  ),
                  MyTextField(
                      prefix: Icons.email_outlined,
                      controller: nameController,
                      obcure: false,
                      label: mytranslate(context, "email")),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0, top: 12),
                    child: MyTextField(
                        prefix: Icons.phone,
                        controller: phoneController,
                        obcure: false,
                        label: mytranslate(context, "mobile")),
                  ),
                  MyTextField(
                      prefix: MdiIcons.city,
                      controller: addressController,
                      obcure: false,
                      label: mytranslate(context, "address")),
                  const SizedBox(height: 24.0),
                  InkWell(
                      child: Container(
                        width: 200,
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
                          btnName ?? mytranslate(context, "verify"),
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: onTap)
                ],
              ),
            ),
          ),
          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: myBlue,
                  child: const Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
