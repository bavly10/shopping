import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/Customer/login/cubit/cubit.dart';
import 'package:shopping/modules/Customer/login/signup/signup.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/cubit/states.dart';
import 'package:shopping/shared/compononet/check_phone_cart.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

import '../../modules/Customer/login/cubit/state.dart';

class PrivacyPolicySignupDialog extends StatelessWidget {
  String? text;
  Future<dynamic>? onchanged;
  // Widget? widget;
  // int? id;
  final GlobalKey<ScaffoldState> skey = GlobalKey<ScaffoldState>();

  PrivacyPolicySignupDialog({
    Key? key,
    this.text,
    this.onchanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        var model = LoginCubit.get(context).privacyPolicy;
        return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              child: model == null
                  ? Container(
                      height: MediaQuery.of(context).size.height * .40,
                      width: MediaQuery.of(context).size.width * .40,
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: CircularProgressIndicator(),
                      ))
                  : Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .80,
                          width: MediaQuery.of(context).size.height * 1,
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
                                Text(
                                  model.data!,
                                  style: const TextStyle(fontSize: 20),
                                  maxLines: 40,
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Checkbox(
                                        activeColor: myBlue,
                                        value: cubit.accept,
                                        onChanged: (value) {
                                          cubit.changeChecked(value!);
                                        }),
                                    Text(
                                      mytranslate(context, "accept"),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            top: -25,
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
                    ),
            ));
      },
    );
  }
}