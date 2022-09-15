import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/cubit/states.dart';
import 'package:shopping/shared/compononet/check_phone_cart.dart';
import 'package:shopping/shared/my_colors.dart';

class PrivacyPolicyDialog extends StatelessWidget {
  String? text;
  Widget? widget;
  int? id;
  final GlobalKey<ScaffoldState> skey = GlobalKey<ScaffoldState>();

  PrivacyPolicyDialog({Key? key, this.text, this.widget, this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = ProductCubit.get(context).privacySalla;
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
                  height: MediaQuery.of(context).size.height * .80,
                  width: MediaQuery.of(context).size.width * .999,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "PrivacyPolicy",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          text!,
                          style: const TextStyle(fontSize: 20),
                          maxLines: 40,
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Checkbox(
                                activeColor: myBlue,
                                value: cubit.accept,
                                onChanged: (value) {
                                  cubit.changeChecked(value!);
                                  if (value == true && cubit.accept) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CheckDialog(
                                            widget: widget!,
                                            id: id,
                                          );
                                        });
                                  }
                                  value = false;
                                }),
                            Text(
                              "Accept",
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
                      child: Icon(
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
