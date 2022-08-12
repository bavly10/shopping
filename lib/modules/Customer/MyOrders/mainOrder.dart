import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/Customer/MyOrders/cubit/cubit.dart';
import 'package:shopping/modules/Customer/MyOrders/cubit/state.dart';
import 'package:shopping/modules/Customer/MyOrders/widget/EXPTile.dart';
import 'package:shopping/shared/my_colors.dart';

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerOrderCubit, CustomerOrderStates>(
      builder: (ctx, state) {
        final cubit = CustomerOrderCubit.get(context).list;
        return Scaffold(
          appBar: AppBar(
              centerTitle: false,
              title: Text(
                "جميع الطلبات من متجرك",
                style: TextStyle(fontSize: 14),
              ),
              actions: [
                CircleAvatar(
                  child: Icon(
                    Icons.search,
                    color: myBlue,
                  ),
                  backgroundColor: myGrey,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    child: Icon(
                      Icons.graphic_eq_sharp,
                      color: myBlue,
                    ),
                    backgroundColor: myGrey,
                  ),
                )
              ]),
          body: SafeArea(
            child: state is CustomerOrderLoading
                ? Center(child: const CircularProgressIndicator())
                : ListView.builder(
                    itemBuilder: (ctx, index) => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[200]!),
                            color: myGrey,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: EXPTile(order: cubit[index])),
                    ),
                    itemCount: cubit.length,
                  ),
          ),
        );
      },
    );
  }
}
