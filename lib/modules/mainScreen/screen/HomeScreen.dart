import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/model/categoryModel.dart';
import 'package:shopping/shared/compononet/arrowBack.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../shared/my_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopStates>(
      builder: (ctx, state) {
        final cubit = ShopCubit.get(context);
        return Scaffold(
          backgroundColor: myGrey,
          body: Column(
            children: [
              cubit.changeAppBar ? myAppBar(context) : myAppBarSearch(context),
              const SizedBox(height: 15,),
              cat(context),
            ],
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
                icon: Icon(Icons.search_sharp, size: 35, color: myBlue,),
                onPressed: () {
                  ShopCubit.get(context).changeSearchAppBar();
                }),
          ),
          SizedBox(width: MediaQuery
              .of(context)
              .size
              .width * 0.25,),
          Text(mytranslate(context, "home"), style: TextStyle(
              color: myBlack, fontWeight: FontWeight.bold, fontSize: 25),),
          Spacer(),
          MyArrowBack(onPress: () {
            Navigator.pop(context);
          },)
        ],
      ),
    );
  }

  Widget myAppBarSearch(context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: PlayAnimation<double>(
        tween: Tween(begin: 0.0, end: MediaQuery
            .of(context)
            .size
            .width * 0.75),
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
                      child: Icon(Icons.search_sharp, size: 50, color: myBlue,),
                    ),
                    const SizedBox(width: 5,),
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.50,
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
              MyArrowBack(onPress: () {
                ShopCubit.get(context).changeSearchAppBar();
              },)
            ],
          );
        },
      ),
    );
  }

  Widget cat(context) {
    final list = ShopCubit
        .get(context)
        .categoryModel;
    return Container(
      height: 150,
      width: double.infinity,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) => buildCate(list!.data![index],context),
          itemCount: list!.data!.length,
        ),
      ),
    );
  }

  Widget buildCate(CatItem item,context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: (){
          print(item.id);
        },
        child: Container(
          decoration: BoxDecoration(
            color:Colors.grey[400],
            borderRadius: BorderRadius.circular(25.0),
          ),
          padding: const EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0),
          child: Column(
            children: [
              SizedBox(
                height: 70,
                width:70,
                child: CachedNetworkImage(
                  imageUrl: "${item.logo}",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,),
                    ),
                  ),
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(height: 10,),
              Text("${item.title}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    );
  }
}