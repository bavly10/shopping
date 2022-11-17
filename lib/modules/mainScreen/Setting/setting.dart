import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/model/language.dart';
import 'package:shopping/modules/mainScreen/Setting/Fav/Fav.dart';
import 'package:shopping/shared/compononet/LoagingDialog.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/myToast.dart';
import 'package:shopping/shared/diohelper/dioHelpoer.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

import 'widget/CustomListTile.dart';
class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (ctx,state){
        if(state is LoadingCat){
          showDialog(
              context: context, builder: (context) => const LoadingDialog());
        }else if (state is DoneCat){
          Navigator.pop(context);
        }else if (state is ErrorCat){
          Navigator.pop(context);
          myToast(message: mytranslate(context, "error"));
        }else {}
      },
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
                Text(mytranslate(context, "nameApp"),style:textStyle1,),
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
                      textTitle: "about",
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
                        ShopCubit.get(context).getCategoriesData(ShopCubit.get(context).type[ShopCubit.get(context).counter!]).then((value) => Navigator.pop(context));
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
                    padding: const EdgeInsets.only(
                      right: 5,
                      bottom: 8,
                      top: 5,
                    ),
                    child: CustomListTile(
                      textTitle: "fav",
                      trailingIcon: Icons.arrow_forward_ios_rounded,
                      onTap: () {navigateTo(context, const Favorite());
                      },
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
