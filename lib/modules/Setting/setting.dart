import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/model/language.dart';
import 'package:shopping/modules/Setting/widget/CustomListTile.dart';
import 'package:shopping/shared/diohelper/dioHelpoer.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit,ShopStates>(
      builder: (ctx,state){
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.png'),
                  radius: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 13, left: 15),
                  child: Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[100],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      right: 5,
                      bottom: 8,
                      top: 5,
                    ),
                    child: CustomListTile(
                      textTitle: "privacy",
                      trailingIcon: Icons.arrow_forward_ios_rounded,
                      onTap: () {

                      },
                    )),
                Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8, top: 5, right: 16, left: 12),
                    child: DropdownButton(
                      isExpanded: true,
                      onChanged: (lang) {
                        ShopCubit.get(context).changeLang(lang);
                        DioHelper.init();
                        ShopCubit.get(context)
                            .getCategoriesData(ShopCubit.get(context).type[ShopCubit.get(context).counter!])
                            .then((value) => build(context));
                      },

                      hint: Text(
                        mytranslate(context, "lang"),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700]),
                      ),
                      items: lanugage.lang_list
                          .map<DropdownMenuItem<lanugage>>(
                              (lang) => DropdownMenuItem(
                            value: lang,
                            child: Row(
                              children: [
                                Text(lang.flag!),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  lang.name!,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[700]),
                                )
                              ],
                            ),
                          ))
                          .toList(),
                      underline: const SizedBox(),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: myBlue,
                        size: 30.0,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 13, left: 15),
                  child: Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[100],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
