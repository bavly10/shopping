import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/model/language.dart';
import 'package:shopping/modules/mainScreen/screen/cateogry.dart';
import 'package:shopping/modules/mainScreen/screen/customer.dart';
import 'package:shopping/shared/compononet/arrowBack.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/diohelper/dioHelpoer.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:simple_animations/simple_animations.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  var search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopStates>(
      builder: (ctx, state) {
        final cubit = ShopCubit.get(context);
        return Scaffold(
          backgroundColor: myGrey,
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
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
                if (state is LoadingProCustomerState)const CircularProgressIndicator(),
                if (state is DoneProCustomerState) CustomerScreen(),
                if (state is emptyProCustomerState) const Text("No data"),
                if (state is ChangeIndexTabs) CustomerScreen(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget myAppBar(context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            color: Colors.grey,
            shape:  StadiumBorder(
              side: BorderSide(
                style: BorderStyle.none,
                color: myBlack,
                width: 6.0,
              ),
            ),
            elevation: 1,
            child: IconButton(
                icon: Icon(
                  Icons.search_sharp,
                  size: 25,
                  color: myBlack,
                ),
                onPressed: () {
                  ShopCubit.get(context).changeSearchAppBar();
                }),
          ),
          SizedBox(width: 10,),
          Text(
            mytranslate(context, "home"),
            style: TextStyle(
                color: myBlue, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const Spacer(),
          DropdownButton(
            onChanged: (lang) {
              ShopCubit.get(context).changeLang(lang);
              DioHelper.init();
              ShopCubit.get(context).getCategoriesData().then((value) =>ShopCubit.get(context).getCustomerData(10)).then((value) =>build(context));
            },
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
                      Text(lang.name!)
                    ],
                  ),
                ))
                .toList(),
            underline: const SizedBox(),
            icon: const Icon(
              Icons.language,
              size: 30.0,
            ),
          ),
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
                        autofocus: true,
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
              const Spacer(),
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
