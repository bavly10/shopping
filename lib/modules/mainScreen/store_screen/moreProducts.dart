import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopping/modules/Customer/cubit/cubit.dart';
import 'package:shopping/modules/Customer/cubit/state.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/details_product/details_product.dart';
import 'package:shopping/modules/mainScreen/store_screen/widgets/latest_product.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/myToast.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

import '../../../shared/compononet/no_result_search.dart';

class MoreProCustomer extends StatelessWidget {
  final int id;
  MoreProCustomer(this.id, {Key? key}) : super(key: key);
  var search = TextEditingController();
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {
        if (state is ProductCustomerNullPagi) {
          myToast(message: mytranslate(context, "noData"));
        }
        else{}
      },
      builder: (context, state) {
        var model = CustomerCubit.get(context).search;
        final cubit = CustomerCubit.get(context).lists;
        return Scaffold(
          backgroundColor: myGrey,
          appBar: AppBar(
            leading: TextField(
              controller: search,
              onChanged: (value) {
                CustomerCubit.get(context).searchCustomer(value);
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
          ),
          body: search.text.isNotEmpty &&
                  CustomerCubit.get(context).search.isEmpty
              ? const NoResultSearch()
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SafeArea(
                    child:  LayoutBuilder(builder: (context, constraint) {
                      return Stack(
                          children: [
                            GridView.custom(
                                controller: scrollController,
                                shrinkWrap: true,
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
                                        (context, index) =>
                                        InkWell(
                                            onTap: () {
                                              ProductCubit.get(context)
                                                  .productInfo(
                                                  cubit[index].id, context)
                                                  .then((value) =>
                                              {
                                                navigateTo(
                                                    context,
                                                    const DetailsProduct())
                                              });
                                            },
                                            child: search.text.isEmpty
                                                ? LatestPro(
                                                productsItem: cubit[index])
                                                : LatestPro(
                                                productsItem: model[index])),
                                    childCount: search.text.isEmpty
                                        ? cubit.length
                                        : model.length)),
                            if (state is ProductCustomerLoading) ...[
                              Positioned(
                                left: 0,
                                bottom: 0,
                                child: SizedBox(
                                  width: constraint.maxWidth,
                                  height: 80,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: myBlue,
                                    ),
                                  ),
                                ),
                              )
                            ]
                          ]
                      );
                    }
                    ),
                  ),
                ),
        );
      },
    );
  }
}
