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
        backgroundColor: myGrey,
        body: cubit.screen[cubit.currentindex],
        bottomNavigationBar: MyNavigationBar(
          index: cubit.currentindex,
          onTap: cubit.changeIndex,
          iconData0:MdiIcons.home,
          lable0: mytranslate(context, "main"),
          iconData3:MdiIcons.accountSupervisorCircleOutline,
          lable3: mytranslate(context, "customer"),
        ),
      );
      },);
  }
}
