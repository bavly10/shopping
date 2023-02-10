import 'package:flutter/material.dart';
import 'package:shopping/shared/compononet/sign_up_cart.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:shopping/shared/compononet/myToast.dart';
import 'package:shopping/shared/compononet/textField.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

import '../../modules/Customer/cubit/cubit.dart';

class CheckDialog extends StatelessWidget {
  String? phoneStore;
  int? id;

  final formKey = GlobalKey<FormState>();
  CheckDialog({Key? key, this.phoneStore, this.id})
      : super(key: key);
  static TextEditingController phoneCheckController = TextEditingController();

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      mytranslate(context, "ph"),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: MyTextField(
                        type: TextInputType.phone,
                        prefix: Icons.phone,
                        controller: phoneCheckController,
                        obcure: false,
                        validate: (value) {
                          if (value!.isEmpty) return mytranslate(context, "INVALIDFIELD");
                          return null;
                        },
                        label: mytranslate(context, "mobile")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: InkWell(
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
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            CustomerCubit.get(context).checkUser(phoneCheckController.text).then((value) {
                              if (CustomerCubit.get(context).check == false) {
                                showDialog(
                                  barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return SignUpCartDialog.SignUpCartDialog();
                                    });
                              } else {
                                CustomerCubit.get(context).connectStore(context: context, userId: id)
                                    .then((value) {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return SignUpCartDialog.SignUpCartDialog();
                                      });
                                });
                              }

                              // Navigator.of(context).pop();
                            });
                          }
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
