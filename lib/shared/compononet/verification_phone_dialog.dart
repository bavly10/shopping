import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shopping/modules/User/cubit/cubit.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/myToast.dart';
import 'package:shopping/shared/compononet/sign_up_dialog.dart';
import 'package:shopping/shared/compononet/textField.dart';

import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

import '../../modules/Customer/cubit/cubit.dart';
import '../../modules/mainScreen/screen/singleCustomerProduct/mainCustomer.dart';

class CheckingDialog extends StatelessWidget {
  final Widget widget;
  final formKey = GlobalKey<FormState>();
  CheckingDialog({Key? key,required this.widget}) : super(key: key);
  TextEditingController phoneController = TextEditingController();

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
    return Form(
      key: formKey,
      child: Container(
        margin: const EdgeInsets.only(left: 0.0, right: 0.0),
        child: Stack(
          children: <Widget>[
            Container(
              height: 250,
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    mytranslate(context, "ph"),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: MyTextField(
                        type: TextInputType.phone,
                        prefix: Icons.phone,
                        controller: phoneController,
                        obcure: false,
                        validate: (value) {
                          if (value!.isEmpty) return "INVALID FIELD";
                          return null;
                        },
                        label: mytranslate(context, "mobile")),
                  ),
                  const SizedBox(height: 24.0),
                  InkWell(
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
                        child: Text(mytranslate(context, "verify"),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (formKey.currentState!.validate()) {
                          CustomerCubit.get(context).checkUser(phoneController.text).then((value) {
                            if (CustomerCubit.get(context).check == false) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return widget;
                                  });
                              // Navigator.of(context).pop();
                            } else {
                              myToast(message: "you are  registered..");
                            }
                          });
                        }
                        // Navigator.of(context).pop();
                      })
                ],
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
      ),
    );
  }
}
