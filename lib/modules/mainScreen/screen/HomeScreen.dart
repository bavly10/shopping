import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/modules/mainScreen/screen/Welcomebage.dart';
import 'package:shopping/modules/mainScreen/screen/cateogry.dart';
import 'package:shopping/modules/mainScreen/screen/customer.dart';
import 'package:shopping/modules/mainScreen/screen/myCart.dart';
import 'package:shopping/shared/compononet/arrowBack.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:simple_animations/simple_animations.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  var search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (ctx,state){
        if(state is LoadingCat){
          const Center(child: CircularProgressIndicator());
        }else {}
      },
      builder: (ctx, state) {
        final cubit = ShopCubit.get(context);
        return Scaffold(
          backgroundColor: myGrey,
          body: SingleChildScrollView(
            child: Column(
              children: [
                 cubit.changeAppBar
                    ? myAppBar(context)
                    : myAppBarSearch(context),
               const  CartWidget(),
               state is LoadingCat?
               const Center(child: CircularProgressIndicator())
                   :CategoryScreen(
                        colntroller: search,
                      ),
                const SizedBox(height: 5,),
                const Divider(
                  height: 1,
                  color: Colors.black,
                ),
                const SizedBox(height: 10,),
                if (state is LoadingProCustomerState)const CircularProgressIndicator(),
               state is DoneProCustomerState? CustomerScreen(): const Welcome(),
                if (state is emptyProCustomerState)  Text(mytranslate(context, "noData"),style: const TextStyle(),),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget myAppBar(context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color:myBlue,
            shape: StadiumBorder(
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
                  color: myWhite,
                ),
                onPressed: () {
                  ShopCubit.get(context).changeSearchAppBar();
                }),
          ),
          Text(
            mytranslate(context, "home"),
            style: TextStyle(
                color: myBlue, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          MyArrowBack(onPress: ()=>Navigator.pop(context)),
        ],
      ),
    );
  }

  Widget myAppBarSearch(context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: PlayAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: MediaQuery.of(context).size.width * 0.75),
        duration: const Duration(seconds: 1),
        delay: const Duration(milliseconds: 20),
        curve: Curves.easeOut,
        builder: (context, value, child) {
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
