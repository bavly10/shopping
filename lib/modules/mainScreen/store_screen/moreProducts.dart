import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopping/model/ProductsCustomer.dart';

import 'package:shopping/model/product.dart';
import 'package:shopping/modules/Customer/cubit/cubit.dart';
import 'package:shopping/modules/Customer/cubit/state.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/cubit/states.dart';
import 'package:shopping/modules/Customer/products/details_product/details_product.dart';
import 'package:shopping/modules/Customer/products/updateProduct.dart';
import 'package:shopping/modules/mainScreen/store_screen/widgets/latest_product.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/myToast.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

class MoreProCustomer extends StatelessWidget {
  final int id;
   const MoreProCustomer(this.id, {Key? key}) : super(key: key) ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {
        if (state is ProductCustomerNullPagi) {
          myToast(message: mytranslate(context, "noData"));
        } else {}
      },
      builder: (context, state) {
        final cubit = CustomerCubit.get(context).lists;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            actions: [
              state is ProductCustomerNullPagi
                  ? const Text("No more")
                  : TextButton(
                  onPressed: () {
                    CustomerCubit.get(context).pagnationDataCurrent();
                    CustomerCubit.get(context).getProductCustomerPagination(id);
                  },
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: myBlue,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        mytranslate(context, "more"),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                  ))
            ],
          ),
          body: SafeArea(
            child: GridView.custom(
                shrinkWrap: true,
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
                      alignment:
                      AlignmentDirectional.centerEnd,
                    ),
                  ],
                ),
                childrenDelegate:
                SliverChildBuilderDelegate(
                        (context, index) => InkWell(
                        onTap: () {
                          ProductCubit.get(context).productInfo(cubit[index].id, context).then((value) => {
                            navigateTo(context, const DetailsProduct())
                          });
                        },
                        child: LatestPro(productsItem: cubit[index])), childCount: cubit.length)),
          ),
        );
      },
    );
  }

}
