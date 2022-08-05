import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopping/modules/Customer/cubit/cubit.dart';
import 'package:shopping/modules/Customer/cubit/state.dart';
import 'package:shopping/modules/mainScreen/mainScreen.dart';
import 'package:shopping/modules/mainScreen/store_screen/widgets/Recently_Card.dart';
import 'package:shopping/modules/mainScreen/store_screen/widgets/top_screen.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/my_colors.dart';

import '../../../shared/localization/translate.dart';
import '../../Customer/products/cubit/cubit.dart';
import '../../Customer/products/details_product/details_product.dart';
import '../screen/singleCustomerProduct/mainCustomer.dart';
import '../screen/singleCustomerProduct/products_card.dart';

class StoreScreen extends StatelessWidget {
  String? title;
  String? image;
  int? id;
  String? adress;

  StoreScreen({Key? key, this.id, this.title, this.image, this.adress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomerCubit.get(context).getProductCustomer(id);
    return BlocConsumer<CustomerCubit, CustomerStates>(
        listener: ((context, state) {}),
        builder: (context, state) {
          var cubit = CustomerCubit.get(context);
          return Scaffold(
            backgroundColor: myGrey,
            appBar: AppBar(backgroundColor: myGrey),
            drawer: Drawer(
              child: Container(),
            ),
            body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: TopScreen(
                          adress: adress,
                          image: image,
                          title: title,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 20, bottom: 20),
                      child: Text(mytranslate(context, "best"),
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * .7,
                      padding: const EdgeInsets.only(right: 8, left: 8),
                      // width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemExtent: 180,
                        itemBuilder: ((context, index) {
                          return RecentlyCard(
                            pro: cubit.list[index],
                          );
                        }),
                        itemCount: cubit.list.length,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 20, bottom: 20),
                          child: Text(mytranslate(context, "recent"),
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                        ),
                        Spacer(),
                        TextButton(
                            onPressed: () {
                              navigateTo(context,
                                  MainCustomer(id: id!, title: title!));
                            },
                            child: Text(
                              mytranslate(context, "more"),
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: myBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "${mytranslate(context, "have")} ${cubit.list.length} ${mytranslate(context, "prod")}"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .8,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
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
                                  alignment: AlignmentDirectional.centerEnd,
                                ),
                              ],
                            ),
                            childrenDelegate: SliverChildBuilderDelegate(
                                (context, index) => InkWell(
                                    onTap: () {
                                      ProductCubit.get(context)
                                          .productInfo(
                                              cubit.list[index].id, context)
                                          .then((value) => {
                                                navigateTo(context,
                                                    const DetailsProduct())
                                              });
                                    },
                                    child: ProductCard(
                                        productsItem: cubit.list[index])),
                                childCount: cubit.list.length)),
                      ),
                    ),
                  ]),
            ),
          );
        });
  }
}
