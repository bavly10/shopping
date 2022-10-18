import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/Customer/MyOrders/cubit/cubit.dart';
import 'package:shopping/modules/Customer/MyOrders/cubit/state.dart';
import 'package:shopping/shared/localization/translate.dart';

class MyTextFiledSearch extends StatelessWidget {
  final TextEditingController search;
  const MyTextFiledSearch(this.search);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerOrderCubit,CustomerOrderStates>(
      builder: (ctx,state){
        return TextField(
          controller: search,
          onChanged: (value) {
            CustomerOrderCubit.get(context).searchCustomerInOrders(value);
          },
          decoration: InputDecoration(
            prefixIcon: search.text.isEmpty
                ? const Icon(
              Icons.search,
            )
                : const Text(""),
            border: InputBorder.none,
            hintText: mytranslate(context, "search"),
          ),
        );
      },
    );
  }
}
