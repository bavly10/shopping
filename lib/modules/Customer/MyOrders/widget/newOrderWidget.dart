import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshoop/modules/Customer/MyOrders/NewOrder/NewOrder.dart';
import 'package:myshoop/modules/Customer/MyOrders/cubit/cubit.dart';
import 'package:myshoop/modules/Customer/MyOrders/cubit/state.dart';
import 'package:myshoop/shared/compononet/componotents.dart';
import 'package:myshoop/shared/localization/translate.dart';
import 'package:myshoop/shared/my_colors.dart';
import 'package:sizer/sizer.dart';

class NewOrderWidget extends StatelessWidget {
  const NewOrderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerOrderCubit,CustomerOrderStates>(
      builder: (ctx,state){
        return CustomerOrderCubit.get(context).listNew.isEmpty?const SizedBox():Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
              decoration: BoxDecoration(
                  gradient: myLinears,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20)),
              child: MaterialButton(
                onPressed: () {
                  navigateTo(context, const NewOrder());
                },
                child:Center(
                  child: Text(
                    mytranslate(context, "newOrder"),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}