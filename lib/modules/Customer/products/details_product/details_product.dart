import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/cubit/states.dart';
import 'package:shopping/modules/Customer/products/details_product/widgets/background_container.dart';
import 'package:shopping/modules/Customer/products/details_product/widgets/container_details.dart';
import 'package:shopping/modules/Customer/products/details_product/widgets/image_container.dart';
import 'package:shopping/modules/cart/cart.dart';
import 'package:shopping/shared/compononet/LoagingDialog.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/myToast.dart';

import '../../../mainScreen/mainScreen.dart';

class DetailsProduct extends StatelessWidget {
  const DetailsProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (ctx,state){
        if (state is ShopEarnLoadingState ){
          const LoadingDialog();
        }else if (state is ShopEarnSuessState){
          navigateTo(context, CartScreen());
        }else if (state is ErrorEarnState){
          myToast(message: "Try again");
        }else{}
      },
        builder: (context, state) {
      final model = ProductCubit.get(context).proInf;
      final cubit = ProductCubit.get(context);
      return model == null
          ? const Padding(
              padding: EdgeInsets.all(27.0),
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Stack(
                          children: [
                        CustomBackgroundContainer(
                          arrowBack: () {
                            Navigator.pop(context);
                          },
                          cartShopping: () {
                           ProductCubit.get(context).getEarn();
                           },
                          x: cubit.itemcount,
                        ),
                        Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                                padding: const EdgeInsets.only(top: 70),
                                child: CustomImageContainer(
                                    image: model.data!.images!))),
                        Positioned(
                            top: MediaQuery.of(context).size.height * .52,
                            child: CustomContainerDetails(
                              id: model.data!.id,
                              name: model.data!.title,
                              price: model.data!.price,
                              rating: 4,
                              image: model.data!.images![0].logo,
                              desc: model.data!.desc,
                              many: cubit.itemCount,
                            )),
                      ]),
                      const SizedBox(height: 1)
                    ],
                  ),
                ),
              ),
            );
    });
  }
}
