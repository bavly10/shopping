import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/Customer/MyOrders/cubit/cubit.dart';
import 'package:shopping/modules/Customer/MyOrders/cubit/state.dart';
import 'package:shopping/modules/Customer/MyOrders/widget/EXPTile.dart';

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerOrderCubit,CustomerOrderStates>(
      builder: (ctx,state){
        final cubit=CustomerOrderCubit.get(context).list;
        return SafeArea(
          child: state is CustomerOrderLoading? CircularProgressIndicator():ListView.builder(itemBuilder: (ctx,index)=>EXPTile(order: cubit[index]),itemCount: cubit.length,),
        );
      },
    );
  }
}
