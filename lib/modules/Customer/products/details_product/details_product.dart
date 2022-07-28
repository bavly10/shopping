import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/cubit/states.dart';
import 'package:shopping/modules/Customer/products/details_product/widgets/background_container.dart';
import 'package:shopping/modules/Customer/products/details_product/widgets/container_details.dart';
import 'package:shopping/modules/Customer/products/details_product/widgets/image_container.dart';

class DetailsProduct extends StatelessWidget {
  const DetailsProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
        listener: ((context, state) {}),
        builder: (context, state) {
          var cubit = ProductCubit.get(context);
          var model = ProductCubit.get(context).proInf;
          return Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Stack(children: [
                    CustomBackgroundContainer(
                      arrowBack: () {
                        //  navigateTo(context, RestarantLayout());
                      },
                      cartShopping: () {},
                    ),
                    Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 70),
                            child: CustomImageContainer(
                                image: model!.data!.images!))),
                    Positioned(
                        top: 420,
                        child: CustomContainerDetails(
                          name: model.data!.title,
                          price: model.data!.price,
                          rating: 4,
                          desc: model.data!.desc,
                        )),
                  ]),
                  SizedBox(height: 1)
                ],
              ),
            ),
          );
        });
  }
}
