import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshoop/modules/Customer/MyOrders/NewOrder/NoOrder.dart';
import 'package:myshoop/modules/Customer/MyOrders/cubit/cubit.dart';
import 'package:myshoop/modules/Customer/MyOrders/cubit/state.dart';
import 'package:myshoop/modules/Customer/MyOrders/widget/EXPTile.dart';
import 'package:myshoop/shared/localization/translate.dart';
import 'package:myshoop/shared/my_colors.dart';

class NewOrder extends StatelessWidget {
  const NewOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerOrderCubit, CustomerOrderStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        final cubit = CustomerOrderCubit.get(context).listNew;
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                mytranslate(context, "orders"),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${cubit.length}",style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18)),
                        const SizedBox(width: 15,),
                        Text("Your Orders",style: TextStyle(color: myBlack,fontWeight: FontWeight.bold,fontSize: 18),),
                      ],
                    ),
                  ),
                  Divider(height: 1,color: myBlack,),
                  cubit.isEmpty
                      ? const NoOrders()
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) => Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: myGrey,
                                  border: Border.all(color: Colors.grey[200]!),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: EXPTile(order: cubit[index],index: index,visable: true)),
                          ),
                          itemCount: cubit.length,
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
