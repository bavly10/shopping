import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopping/model/product.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/cubit/states.dart';
import 'package:shopping/modules/Customer/products/updateProduct.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/myToast.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

import '../../../shared/compononet/no_result_search.dart';

class MoreProductsCustomer extends StatelessWidget {
  final ScrollController scrollController = ScrollController();
  var search = TextEditingController();
  MoreProductsCustomer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    getMoreProduct(context);
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (context, state) {
        if (state is GettingProductDataNull) {
          myToast(message: mytranslate(context, "noData"));
        } else {}
      },
      builder: (context, state) {
        final cubit = ProductCubit.get(context).listProducts;
        var model = ProductCubit.get(context).search;
        return Scaffold(
            backgroundColor: myGrey,
            appBar: AppBar(
              title: Text(mytranslate(context, "my")),
              leading: TextField(
                controller: search,
                onChanged: (value) {
                  ProductCubit.get(context).searchCustomer(value);
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
              leadingWidth: 200,
            ),
            body: search.text.isNotEmpty &&
                    ProductCubit.get(context).search.isEmpty
                ? const NoResultSearch()
                : SafeArea(
                    child: LayoutBuilder(builder: (context, constraint) {
                      return Stack(
                        children: [
                          ListView.builder(
                            controller: scrollController,
                            itemBuilder: (ctx, index) => Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 12, right: 12, bottom: 8),
                              child: search.text.isEmpty
                                  ? myCard(context: context, pro: cubit[index])
                                  : myCard(context: context, pro: model[index]),
                            ),
                            itemCount: search.text.isEmpty
                                ? cubit.length
                                : model.length,
                          ),
                          if (state is GettingProductDataLoading) ...[
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
                        ],
                      );
                    }),
                  ));
      },
    );
  }

  Widget myCard({context, required ProductItemMainCustomer pro}) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white, //background color of dropdown button
            border: Border.all(
                color: myGrey!,
                //color: HexColor('#A7B3CF'),
                width: 5), //border of dropdown button
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .33,
                    height: MediaQuery.of(context).size.height * .10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(pro.images![0].logo!),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(pro.titleAr!,
                          style: const TextStyle(
                            // color: HexColor(
                            //     '#A7B3CF'),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: pro.price!,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                          const TextSpan(text: " "),
                          TextSpan(
                              text: mytranslate(context, "wd"),
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            Container(
              // color: HexColor('#A7B3CF'),
              height: 1,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 20, right: 10, bottom: 15),
                  child: Text("${pro.many!}  ${mytranslate(context, "pic")}",
                      style: const TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold)),
                ),
                Spacer(),
                TextButton(
                    onPressed: () async {
                      ProductCubit.get(context).showPro(pro.id, context).then(
                          (value) => {navigateTo(context, UpdateProduct())});
                    },
                    child: Text(
                      mytranslate(context, "editt"),
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: myBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    )),
              ],
            ),

            //  Text(cubit.list[index].)
          ]),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  void getMoreProduct(context) {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        ProductCubit.get(context).pagnationDataLimit();
        ProductCubit.get(context)
            .getProducts(context, ProductCubit.get(context).limit);
        print("new Data Loading");
      }
    });
  }
}
