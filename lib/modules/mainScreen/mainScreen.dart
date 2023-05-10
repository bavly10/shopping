import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myshoop/Cubit/cubit.dart';
import 'package:myshoop/Cubit/states.dart';
import 'package:myshoop/model/language.dart';
import 'package:myshoop/shared/compononet/navigationappbar.dart';
import 'package:myshoop/shared/localization/translate.dart';
import 'package:myshoop/shared/my_colors.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).currentindex=0;
    return BlocBuilder<ShopCubit,ShopStates>(
      builder: (ctx,state){
        final cubit = ShopCubit.get(context);
      return SafeArea(
        child: Scaffold(
          backgroundColor: myGrey,
          body: cubit.screen[cubit.currentindex],
          bottomNavigationBar: MyNavigationBar(
            index: cubit.currentindex,
            onTap: cubit.changeIndex,
            iconData0:MdiIcons.home,
            lable0: mytranslate(context, "main"),
            lable1:  mytranslate(context, "setting"),
            iconData1:MdiIcons.settingsHelper,
            iconData3:MdiIcons.accountSupervisorCircleOutline,
            lable3: mytranslate(context, "customer"),

          ),
        ),
      );
      },);
  }
}
