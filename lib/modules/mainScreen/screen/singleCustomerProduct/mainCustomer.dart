import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopping/modules/Customer/cubit/cubit.dart';
import 'package:shopping/modules/Customer/cubit/state.dart';
import 'package:shopping/modules/Customer/products/details_product/details_product.dart';
import 'package:shopping/modules/mainScreen/screen/singleCustomerProduct/products_card.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/my_colors.dart';

import '../../../Customer/products/cubit/cubit.dart';

class MainCustomer extends StatelessWidget {
  final String title;
  final int id;
  const MainCustomer({Key? key, required this.id, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomerCubit.get(context).getProductCustomer(id);
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        final cubit = CustomerCubit.get(context);
        return Scaffold(
          backgroundColor: myGrey,
          appBar: AppBar(
              title: Text(
                title,
                style: TextStyle(color: Colors.black87),
              ),
              centerTitle: true,
              leading: const Icon(Icons.search),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "${cubit.list.length}",
                        style: TextStyle(color: Colors.black87, fontSize: 18),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("product"),
                    ],
                  ),
                )
              ]),
          body: Padding(
            padding: const EdgeInsets.all(14.0),
            child: GridView.custom(
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverWovenGridDelegate.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  pattern: [
                    const WovenGridTile(6 / 7),
                    const WovenGridTile(
                      5 / 7,
                      crossAxisRatio: .9,
                      alignment: AlignmentDirectional.centerEnd,
                    ),
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate(
                  (context, index) => InkWell(
                      onTap: () {
                        ProductCubit.get(context)
                            .productInfo(cubit.list[index].id, context)
                            .then((value) =>
                                {navigateTo(context, DetailsProduct())});
                      },
                      child: ProductCard(productsItem: cubit.list[index])),
                  childCount: cubit.list.length,
                )),
          ),
        );
      },
    );
  }
}
