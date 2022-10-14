import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:shopping/modules/Customer/cubit/cubit.dart';
import 'package:shopping/modules/Customer/cubit/state.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/details_product/details_product.dart';
import 'package:shopping/modules/mainScreen/store_screen/moreProducts.dart';
import 'package:shopping/modules/mainScreen/store_screen/widgets/best_seller_Card.dart';
import 'package:shopping/modules/mainScreen/store_screen/widgets/drawer.dart';
import 'package:shopping/modules/mainScreen/store_screen/widgets/latest_product.dart';
import 'package:shopping/modules/mainScreen/store_screen/widgets/top_screen.dart';
import 'package:shopping/shared/compononet/arrowBack.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

class StoreScreen extends StatelessWidget {
  String? adress, phone, image, rate;
  final String title;
  int? id;

  StoreScreen(
      {Key? key,
      this.id,
      required this.title,
      this.image,
      this.adress,
      this.phone,
      this.rate})
      : super(key: key);
  final _advancedDrawerController = AdvancedDrawerController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    CustomerCubit.get(context).getProductCustomer(id);
    CustomerCubit.get(context).latestproducts(id: id);
    return BlocBuilder<CustomerCubit, CustomerStates>(
        builder: (context, state) {
      var cubit = CustomerCubit.get(context);
      var latest = CustomerCubit.get(context).latestPro;
      return AdvancedDrawer(
        backdropColor: HexColor('#2F69F8'),
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        // openScale: 1.0,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        drawer: CustomDrawer(
          tiltle: title,
          address: adress,
          image: image,
          id: id,
          phoneStore: phone,
          skey: scaffoldKey,
          rate: rate,
        ),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: myGrey,
          appBar: AppBar(
            backgroundColor: myGrey,
            leading: IconButton(
              onPressed: _handleMenuButtonPressed,
              icon: ValueListenableBuilder<AdvancedDrawerValue>(
                valueListenable: _advancedDrawerController,
                builder: (_, value, __) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      value.visible ? Icons.clear : Icons.menu,
                      size: 28,
                      key: ValueKey<bool>(value.visible),
                    ),
                  );
                },
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  right: 8.0,
                  left: 8.0,
                ),
                child: MyArrowBack(
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TopScreen(
                      adress: adress, image: image, title: title, rate: rate)),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 20, bottom: 20, right: 12),
                child: Text(mytranslate(context, "best"),
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              Container(
                height: MediaQuery.of(context).size.width * .7,
                padding: const EdgeInsets.only(
                  right: 8,
                  left: 8,
                ),
                // width: MediaQuery.of(context).size.width,
                child: latest.isEmpty
                    ? Center(
                        child: Text(
                          mytranslate(context, "new"),
                          style: TextStyle(
                              color: myBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemExtent: 180,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: BestCard(
                              pro: latest[index],
                              index: index,
                              list: latest,
                            ),
                          );
                        }),
                        itemCount: latest.length,
                      ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20, bottom: 20, right: 12),
                    child: Text(mytranslate(context, "recent"),
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                  Spacer(),
                 TextButton(
                      onPressed: () {
                        CustomerCubit.get(context).lists = [];
                        CustomerCubit.get(context)
                            .getProductCustomerPagination(id)
                            .then((value) =>
                                navigateTo(context, MoreProCustomer(id!)));
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
              cubit.list.isEmpty
                  ? Center(
                      child: Text(
                        mytranslate(context, "new"),
                        style: TextStyle(
                            color: myBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(14.0),
                      child: GridView.custom(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 18,
                                  crossAxisSpacing: 18,
                                  childAspectRatio: .650),
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: LatestPro(
                                        productsItem: cubit.list[index]),
                                  )),
                              childCount: cubit.list.length)),
                    ),
            ]),
          ),
        ),
      );
    });
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
