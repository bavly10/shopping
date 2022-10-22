import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/modules/mainScreen/Setting/Fav/widgets/buildCard.dart';
import 'package:shopping/modules/mainScreen/Setting/Fav/widgets/empty.dart';
import 'package:shopping/shared/compononet/arrowBack.dart';
import 'package:shopping/shared/localization/translate.dart';

class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopStates>(
      builder: (ctx, state) {
        final cubit = ShopCubit.get(context).favItem;
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: const SizedBox(),
              actions: [
                MyArrowBack(onPress: ()=>Navigator.pop(context))
              ],
              title: Text(mytranslate(context, "fav")),
              centerTitle: true,
            ),
            body:cubit.isNotEmpty
                ? SizedBox(
                    child: ListView.separated(
                        itemBuilder: (context, index) =>
                            BuildCard(model: cubit[index]),
                        separatorBuilder: (context, index) => Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey[300],
                            ),
                        itemCount: cubit.length),
                  )
                : const EmptyFav(),
          ),
        );
      },
    );
  }
}
