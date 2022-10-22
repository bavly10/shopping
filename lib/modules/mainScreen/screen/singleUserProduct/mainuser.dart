import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/details_product/details_product.dart';
import 'package:shopping/modules/mainScreen/screen/singleUserProduct/products_card.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/no_result_search.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

class MainUser extends StatelessWidget {
  final String title;
  final int id;
  MainUser({Key? key, required this.id, required this.title})
      : super(key: key);
  var search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).getProductCustomer(id);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        final cubit = ShopCubit.get(context);
        return Scaffold(
          backgroundColor: myGrey,
          appBar: AppBar(
              title: Text(
                title,
                style: TextStyle(color: Colors.black87),
              ),
              leading: TextField(
                controller: search,
                onChanged: (value) {
                  cubit.searchCustomer(value);
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
              ),
              centerTitle: true,
              leadingWidth: 200,
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
          body: search.text.isNotEmpty && cubit.search.isEmpty
              ? const NoResultSearch()
              : Padding(
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
                            child: search.text.isEmpty
                                ? ProductCard(productsItem: cubit.list[index])
                                : ProductCard(
                                    productsItem: cubit.search[index])),
                        childCount: search.text.isEmpty
                            ? cubit.list.length
                            : cubit.search.length,
                      )),
                ),
        );
      },
    );
  }
}
