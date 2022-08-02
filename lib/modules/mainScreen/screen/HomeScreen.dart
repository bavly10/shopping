import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/modules/mainScreen/screen/cateogry.dart';
import 'package:shopping/modules/mainScreen/screen/customer.dart';
import 'package:shopping/shared/compononet/arrowBack.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../Customer/cubit/cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  var search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        final cubit = ShopCubit.get(context);
        return Scaffold(
          backgroundColor: myGrey,
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                cubit.changeAppBar
                    ? myAppBar(context)
                    : myAppBarSearch(context),
                const SizedBox(
                  height: 15,
                ),
                // ignore: prefer_const_constructors
                CategoryScreen(
                  colntroller: search,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  height: 1,
                  color: Colors.black,
                ),
                if (state is LoadingProCustomerState)
                  const CircularProgressIndicator(),
                if (state is DoneProCustomerState) CustomerScreen(),
                if (state is emptyProCustomerState) const Text("No data"),
              ],
            ),
          ),
        );
      },
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
                        controller: search,
                        onChanged: (value) {
                          ShopCubit.get(context).searchCateogry(value);
                        },
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
