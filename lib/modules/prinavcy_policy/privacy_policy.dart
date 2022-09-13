import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/model/privacy_policy.dart';
import 'package:shopping/modules/prinavcy_policy/widgets/wave_clip.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

class PrivacyApolicy extends StatelessWidget {
  const PrivacyApolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).getPrivacyPolicy();
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: ((context, state) {}),
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          var model = cubit.privacyPolicy;
          return model?.data == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipPath(
                      clipper: WaveClip(),
                      child: Container(
                          height: MediaQuery.of(context).size.height * .2,
                          color: myBlue,
                          child: Center(
                              child: Text(
                            mytranslate(context, "privacy"),
                            style: const TextStyle(
                                fontSize: 33,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ))),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          model!.data!,
                          maxLines: 30,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        )),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              mytranslate(context, "yeah"),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: myBlue,
                                  fontWeight: FontWeight.w600),
                            )),
                        Checkbox(
                            value: cubit.privacyy,
                            onChanged: (value) =>
                                cubit.changePrivacyChecked(value!))
                      ],
                    )
                  ],
                );
        });
  }
}
