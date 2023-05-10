import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myshoop/modules/cart/widget/floatingOrder.dart';
import 'package:myshoop/shared/compononet/myToast.dart';
import 'package:slide_popup_dialog_null_safety/slide_popup_dialog.dart' as slideDialog;
import 'package:myshoop/modules/Customer/products/cubit/cubit.dart';
import 'package:myshoop/modules/Customer/products/cubit/states.dart';
import 'package:myshoop/modules/cart/widget/widget_cart.dart';
import 'package:myshoop/shared/localization/translate.dart';
import 'package:myshoop/shared/my_colors.dart';


class CartScreen extends StatelessWidget {
  bool x=false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (ctx, state) {
        if (state is ShopEarnLoadingState ){
          x=true;
          myToast(message:mytranslate(context, "loading"));
        }else if (state is ShopEarnSuessState){
          x=false;
          slideDialog.showSlideDialog(
            context: context,
            child: MyFloating(),
            pillColor: Colors.red,
            backgroundColor: myWhite,
          );
        }else if (state is ErrorEarnState){
          x=false;
          Navigator.pop(context);
          myToast(message:mytranslate(context, "error"));
        }else{}
      },
      builder: (ctx, state) {
        final cubit = ProductCubit.get(context);
        return SafeArea(
          child: Scaffold(
            floatingActionButton: x?null:(
                FloatingActionButton(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(mytranslate(context, "pay")),
              ),
              onPressed: () async{
               await cubit.getEarn();
              },
            )),
            backgroundColor: myWhite,
            body: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          mytranslate(context, "prod"),
                          style: TextStyle(
                              color: myBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "${cubit.itemcount}",
                          style: TextStyle(
                              color: myBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Text(
                                mytranslate(context, "bag"),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: cubit.items.isEmpty
                        ? Center(
                            child: Text(
                            mytranslate(context, "empty"),
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: myBlue),
                          ))
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: cubit.items.length,
                            itemBuilder: (ctx, index) => Cartitemapp(
                                  size: cubit.items.values.toList()[index].size,
                                  id: cubit.items.values.toList()[index].id,
                                  proid: cubit.items.keys.toList()[index],
                                  title:
                                      cubit.items.values.toList()[index].title,
                                  imgurl:
                                      cubit.items.values.toList()[index].imgurl,
                                  quant: cubit.items.values
                                      .toList()[index]
                                      .quantity,
                                  price:
                                      cubit.items.values.toList()[index].price,
                                  rate: cubit.items.values.toList()[index].rate,
                                )),
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
