import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/Customer/MyOrders/cubit/cubit.dart';
import 'package:shopping/modules/Customer/MyOrders/cubit/state.dart';
import 'package:shopping/shared/compononet/blueButton.dart';
import 'package:shopping/shared/compononet/myToast.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:sizer/sizer.dart';


class ConfirmOrderDialog extends StatelessWidget {
  final String text;
  final int id,index;
  const ConfirmOrderDialog({Key? key,required this.text,required this.id,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerOrderCubit,CustomerOrderStates>(
      listener: (ctx,state){
        if (state is UpdateOrderCustomerDone){
          CustomerOrderCubit.get(context).removeIndexList(index);
          Navigator.pop(context);
        }else if (state is UpdateOrderCustomerFail) {
          myToast(message: mytranslate(context, "error"));
        }
          else{}
      },
      builder: (ctx,state){
        return AlertDialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          elevation: 0.0,
          content: dialogContent(context),
        );
      },
    );
  }

  Widget dialogContent(BuildContext context) {
    return SizedBox(
      height:25.h,
      width:double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(mytranslate(context, "dialogOrder"),style: const TextStyle(color: Colors.black),),
          const SizedBox(height: 5,),
          Expanded(child: Text(text,style: TextStyle(color: myBlue,fontWeight: FontWeight.bold),)),
          const SizedBox(height: 25,),
         BlueButton(title: Text(mytranslate(context, "ok"),style: TextStyle(color: myWhite),), hight: 0.07, width: 25,
           onpress: ()async{
          await CustomerOrderCubit.get(context).updateOrders(id: id,context: context);
         },)
        ],
      ),
    );
  }
}