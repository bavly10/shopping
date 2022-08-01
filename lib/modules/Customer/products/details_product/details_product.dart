import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/cubit/states.dart';
import 'package:shopping/modules/Customer/products/details_product/widgets/background_container.dart';
import 'package:shopping/modules/Customer/products/details_product/widgets/container_details.dart';
import 'package:shopping/modules/Customer/products/details_product/widgets/image_container.dart';
import 'package:shopping/modules/cart/cart.dart';
import 'package:shopping/shared/compononet/componotents.dart';

import '../../../../shared/compononet/myToast.dart';
import '../../../../shared/localization/translate.dart';
import '../../../../shared/verification_dialog.dart';
import '../../../mainScreen/mainScreen.dart';

class DetailsProduct extends StatelessWidget {
  const DetailsProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductStates>(builder: (context, state) {
      final model = ProductCubit.get(context).proInf;
      final cubit = ProductCubit.get(context);
      return Scaffold(
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Stack(children: [
                CustomBackgroundContainer(
                  arrowBack: () {
                    navigateToFinish(context, MainScreen());
                  },
                  cartShopping: () {
                    navigateTo(context, CartScreen());
                  },
                  x: cubit.itemcount,
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 70),
                        child:
                            CustomImageContainer(image: model!.data!.images!))),
                Positioned(
                    top: 420,
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
      );
    });
  }
}
