import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/model/language.dart';
import 'package:shopping/shared/compononet/navigationappbar.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (ctx,state){},
      builder: (ctx,state){
        final cubit = ShopCubit.get(context);
      return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
           backgroundColor:  Colors.grey[300],
          elevation: 0,
          iconTheme: const IconThemeData(opacity: 0),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: DropdownButton(
                onChanged: (lang) {
                  cubit.changeLang(lang);
                },
                items: lanugage.lang_list
                    .map<DropdownMenuItem<lanugage>>(
                        (lang) => DropdownMenuItem(value: lang,
                      child: Row(
                        children: [
                          Text(lang.flag!),
                          const SizedBox(width: 10,),
                          Text(lang.name!)],
                      ),
                    ))
                    .toList(),
                underline: const SizedBox(),
                icon: const Icon(
                  Icons.language,
                  size: 30.0,
                ),
              ),
            ),
          ],
        ),
        body: cubit.screen[cubit.currentindex],
        bottomNavigationBar: MyNavigationBar(
          index: cubit.currentindex,
          onTap: cubit.changeIndex,
          iconData0:MdiIcons.home,
          lable0: mytranslate(context, "main"),
          iconData1: MdiIcons.homeCityOutline,
          lable1: mytranslate(context, "Store"),
          iconData2: MdiIcons.cartOutline,
          lable2: mytranslate(context, "cart"),
          iconData3:MdiIcons.accountSupervisorCircleOutline,
          lable3: mytranslate(context, "customer"),
        ),

      );
      },);
  }
}
