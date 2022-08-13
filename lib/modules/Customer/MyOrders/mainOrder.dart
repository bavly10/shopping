import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
        final model = CustomerOrderCubit.get(context).ordersCutomer;

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
                      MdiIcons.chartBar,
                      color: myBlue,
                    ),
                    backgroundColor: myGrey,
                  ),
                )
              ]),
          body: SafeArea(
            child: state is CustomerOrderLoading
                ? const Center(child: const CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                              height: MediaQuery.of(context).size.height * .06,
                              width: double.infinity,
                              child: ListView.separated(
                                  separatorBuilder: ((context, index) {
                                    return const SizedBox(
                                      width: 20,
                                    );
                                  }),
                                  itemCount: CustomerOrderCubit.get(context)
                                      .pages
                                      .length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 400),
                                        height: index ==
                                                CustomerOrderCubit.get(context)
                                                    .selected
                                            ? 40
                                            : 20,
                                        width: index ==
                                                CustomerOrderCubit.get(context)
                                                    .selected
                                            ? 40
                                            : 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: index ==
                                                  CustomerOrderCubit.get(
                                                          context)
                                                      .selected
                                              ? myBlue
                                              : myGrey,
                                          border: Border.all(
                                              color: Colors.grey[200]!),
                                          // color: myGrey,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: InkWell(
                                            onTap: () {
                                              CustomerOrderCubit.get(context)
                                                  .getselected(index);
                                            },
                                            child: Container(
                                                child: Text(
                                              CustomerOrderCubit.get(context)
                                                  .pages[index]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: index ==
                                                          CustomerOrderCubit
                                                                  .get(context)
                                                              .selected
                                                      ? Colors.white
                                                      : myBlue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ))),
                                      ))),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) => Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: myGrey,
                                  border: Border.all(color: Colors.grey[200]!),
                                  // color: myGrey,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: EXPTile(order: cubit[index])),
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
