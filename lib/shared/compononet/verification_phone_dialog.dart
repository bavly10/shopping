import 'package:flutter/material.dart';
import 'package:shopping/shared/compononet/connection_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:shopping/shared/compononet/myToast.dart';
import 'package:shopping/shared/compononet/textField.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

import '../../modules/Customer/cubit/cubit.dart';

class CheckingDialog extends StatelessWidget {
  final Widget widget;
  String? phoneStore;
  int? id;

  final formKey = GlobalKey<FormState>();
  CheckingDialog({Key? key, required this.widget, this.phoneStore, this.id})
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
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: MyTextField(
                        type: TextInputType.number,
                        prefix: Icons.phone,
                        controller: phoneCheckController,
                        obcure: false,
                        validate: (value) {
                          if (value!.isEmpty) return "INVALID FIELD";
                          return null;
                        },
                        label: mytranslate(context, "mobile")),
                  ),
                  const SizedBox(height: 24.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
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
                            CustomerCubit.get(context)
                                .checkUser(phoneCheckController.text)
                                .then((value) {
                              if (CustomerCubit.get(context).check == false) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return widget;
                                    });
                                // Navigator.of(context).pop();
                              } else {
                                CustomerCubit.get(context)
                                    .connectStore(context: context, userId: id)
                                    .then((value) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ConnectoinDialog(
                                          phoneStore: phoneStore,
                                        );
                                      });
                                  // launch('tel:$phoneStore');
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
