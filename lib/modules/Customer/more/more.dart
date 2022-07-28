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

class MoreProductsCustomer extends StatefulWidget {
  const MoreProductsCustomer({Key? key}) : super(key: key);

  @override
  State<MoreProductsCustomer> createState() => _MoreProductsCustomerState();
}

///error hna fe backScreen
class _MoreProductsCustomerState extends State<MoreProductsCustomer> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        ProductCubit.get(context).pagnationDataLimit();
        await ProductCubit.get(context)
            .getProducts(context, ProductCubit.get(context).limit);
        print("new Data Loading");
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (context, state) {
        if (state is GettingProductDataNull) {
          myToast(message: mytranslate(context, "noData"));
        } else {}
      },
      builder: (context, state) {
        final cubit = ProductCubit.get(context).listProducts;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            actions: [
              state is GettingProductDataNull
                  ? const Text("No more")
                  : TextButton(
                      onPressed: () {
                        ProductCubit.get(context).pagnationDataLimit();
                        ProductCubit.get(context).getProducts(
                            context, ProductCubit.get(context).limit);
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
            child: ListView.builder(
              itemBuilder: (ctx, index) =>
                  myCard(context: context, pro: cubit[index]),
              itemCount: cubit.length,
            ),
          ),
        );
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
                //color: HexColor('#A7B3CF'),
                width: 1), //border of dropdown button
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
                          style: TextStyle(
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
                          TextSpan(
                              text: "WD",
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
                  padding: const EdgeInsets.only(top: 10.0, left: 20),
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
                      "Edit Product",
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
}
