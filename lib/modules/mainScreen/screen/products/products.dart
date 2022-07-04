import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/modules/mainScreen/screen/products/widgets/products_card.dart';
import 'package:shopping/shared/compononet/arrowBack.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:simple_animations/stateless_animation/play_animation.dart';

import '../../../../shared/my_colors.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = ShopCubit.get(context);

    return Scaffold(
      backgroundColor: myGrey,
      body: Column(
        children: [
          cubit.changeAppBar ? myAppBar(context) : myAppBarSearch(context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: GridView.custom(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverWovenGridDelegate.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    pattern: [
                      const WovenGridTile(1),
                      const WovenGridTile(
                        5 / 7,
                        crossAxisRatio: .9,
                        alignment: AlignmentDirectional.centerEnd,
                      ),
                    ],
                  ),
                  childrenDelegate: SliverChildBuilderDelegate(
                    (context, index) => const ProductCard(),
                    childCount: 10,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget myAppBar(context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Card(
            color: Colors.grey,
            shape: const StadiumBorder(
              side: BorderSide(
                style: BorderStyle.solid,
                color: Colors.grey,
                width: 6.0,
              ),
            ),
            elevation: 1,
            child: IconButton(
                icon: Icon(
                  Icons.search_sharp,
                  size: 35,
                  color: myBlue,
                ),
                onPressed: () {
                  ShopCubit.get(context).changeSearchAppBar();
                }),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
          ),
          Text(
            mytranslate(context, "home"),
            style: TextStyle(
                color: myBlack, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Spacer(),
          MyArrowBack(
            onPress: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Widget myAppBarSearch(context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: PlayAnimation<double>(
        tween: Tween(begin: 0.0, end: MediaQuery.of(context).size.width * 0.75),
        duration: const Duration(seconds: 1),
        delay: const Duration(milliseconds: 20),
        curve: Curves.easeOut,
        builder: (context, child, value) {
          return Row(
            children: [
              Container(
                width: value,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.0),
                    color: Colors.grey),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: Colors.grey,
                      shape: const StadiumBorder(
                        side: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.grey,
                          width: 6.0,
                        ),
                      ),
                      elevation: 1,
                      child: Icon(
                        Icons.search_sharp,
                        size: 50,
                        color: myBlue,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: mytranslate(context, "search"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              MyArrowBack(
                onPress: () {
                  ShopCubit.get(context).changeSearchAppBar();
                },
              )
            ],
          );
        },
      ),
    );
  }
}
