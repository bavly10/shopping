import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopping/modules/Customer/cubit/cubit.dart';
import 'package:shopping/modules/Customer/cubit/state.dart';
import 'package:shopping/modules/Customer/singleCustomerProduct/products_card.dart';

class MainCustomer extends StatelessWidget {
 final String title;
 final int id;
  const MainCustomer({Key? key,required this.id,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomerCubit.get(context).getProductCustomer();
    return BlocConsumer<CustomerCubit,CustomerStates>(
      listener: (ctx,state){},
      builder: (ctx,state){
        final cubit=CustomerCubit.get(context);
        return Scaffold(
          appBar: AppBar(title: Text(title),centerTitle: true,leading: const Icon(Icons.search)),
          body: Padding(
            padding: const EdgeInsets.all(14.0),
            child: GridView.custom(
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverWovenGridDelegate.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  pattern: [
                    const WovenGridTile(1),
                    const WovenGridTile(
                      5 / 7,
                      crossAxisRatio: .9,
                      alignment: AlignmentDirectional.centerEnd,
                    ),
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate((context, index) =>  ProductCard(productsItem: cubit.list[index]),
                  childCount: cubit.list.length,
                )),
          ),
        );
      },
    );
  }
}
