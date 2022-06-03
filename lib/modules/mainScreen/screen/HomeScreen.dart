import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/shared/compononet/arrowBack.dart';
import 'package:shopping/shared/localization/translate.dart';

import '../../../shared/my_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit,ShopStates>(
      builder: (ctx,state){
        final cubit= ShopCubit.get(context);
        return Scaffold(
          backgroundColor: myGrey,
          appBar:cubit.changeAppBar?myAppBar(context):myAppBarSearch(context),
        );
      },
    );
  }
  AppBar myAppBar(context){
    return AppBar(
      backgroundColor:myGrey,
      elevation: 0.0,
      title: Text(mytranslate(context, "home")),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey
        ),child: IconButton(icon: Icon(Icons.search_sharp,size: 25,color: myBlue,),
            onPressed: (){
          ShopCubit.get(context).changeSearchAppBar();
            } ))
      ),
      actions: [
        MyArrowBack(onPress: (){
       Navigator.pop(context);
        },)
      ],
    );
  }

  AppBar myAppBarSearch(context){
    return AppBar(
      iconTheme: IconThemeData(opacity: 0),
      backgroundColor:myGrey,
      elevation: 0.0,
    flexibleSpace: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(45.0),color: Colors.grey),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color:Colors.grey,
            shape: const StadiumBorder(
              side: BorderSide(
                style: BorderStyle.solid,
                color:Colors.grey,
                width: 6.0,
              ),
            ),
            elevation: 1,
            child: Icon(Icons.search_sharp,size: 50,color: myBlue,),
          ),
          const SizedBox(width: 5,),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.50,
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText:mytranslate(context, "search"),
              ),
            ),
          ),
          const Spacer(),
          MyArrowBack(onPress: (){
            ShopCubit.get(context).changeSearchAppBar();
          },)
        ],
      ),
    ),
      centerTitle: false,
    );
  }
}
