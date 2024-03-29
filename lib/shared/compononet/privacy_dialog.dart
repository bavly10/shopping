import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshoop/modules/Customer/products/cubit/cubit.dart';
import 'package:myshoop/modules/Customer/products/cubit/states.dart';
import 'package:myshoop/shared/compononet/check_phone_cart.dart';
import 'package:myshoop/shared/localization/translate.dart';
import 'package:myshoop/shared/my_colors.dart';
import 'package:sizer/sizer.dart';

class PrivacyPolicyDialog extends StatelessWidget {
  String? text;
  int? id;
  final GlobalKey<ScaffoldState> skey = GlobalKey<ScaffoldState>();

  PrivacyPolicyDialog({Key? key, this.text,this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (context, state) {
        if (ProductCubit.get(context).accept) {}
      },
      builder: (context, state) {
        var cubit = ProductCubit.get(context);
        return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  height:85.h,
                  width: MediaQuery.of(context).size.width * .999,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            mytranslate(context, "policy"),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.red[900]),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        text == null
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : SizedBox(
                          height: 60.h,
                          child: SingleChildScrollView(
                            child: Text(
                             text!,
                              style: const TextStyle(fontSize: 18,height: 2,wordSpacing: 5),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                                activeColor: myBlue,
                                value: cubit.accept,
                                onChanged: (value) {
                                  cubit.changeChecked(value!);
                                  if (value == true) {
                                    Navigator.of(context).pop();
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CheckDialog(
                                            id: id,
                                          );
                                        });
                                  }
                                  value = false;
                                }),
                            Text(
                              mytranslate(context, "accept"),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: -60,
                    child: CircleAvatar(
                      backgroundColor: myBlue,
                      radius: 50,
                      child: const Icon(
                        Icons.privacy_tip_rounded,
                        color: Colors.white,
                        size: 45,
                      ),
                    )),
              ],
            ));
      },
    );
  }
}
