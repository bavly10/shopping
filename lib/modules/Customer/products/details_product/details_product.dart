import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshoop/modules/Customer/products/cubit/cubit.dart';
import 'package:myshoop/modules/Customer/products/cubit/states.dart';
import 'package:myshoop/modules/Customer/products/details_product/widgets/background_container.dart';
import 'package:myshoop/modules/Customer/products/details_product/widgets/container_details.dart';
import 'package:myshoop/modules/Customer/products/details_product/widgets/image_container.dart';
import 'package:myshoop/modules/cart/cart.dart';
import 'package:myshoop/shared/compononet/LoagingDialog.dart';
import 'package:myshoop/shared/compononet/componotents.dart';
import 'package:myshoop/shared/compononet/myToast.dart';
import 'package:myshoop/shared/localization/translate.dart';
import 'package:myshoop/shared/my_colors.dart';
import 'package:sizer/sizer.dart';

import '../../../mainScreen/mainScreen.dart';

class DetailsProduct extends StatelessWidget {
  const DetailsProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (ctx,state){
       if (state is ShopEarnSuessState){
          navigateToFinish(context, CartScreen());
        }else if (state is ErrorEarnState){
          myToast(message: "Try again");
        }else{}
      },
        builder: (context, state) {
      final model = ProductCubit.get(context).proInf;
      final cubit = ProductCubit.get(context);
      return model == null
          ?Text(mytranslate(context, "error"))
          : Scaffold(
        backgroundColor: myGrey,
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                      children: [
                        CustomBackgroundContainer(
                          arrowBack: () {
                            Navigator.pop(context);
                          },
                          cartmyshoop: () {
                            ProductCubit.get(context).getEarn();
                          },
                          x: cubit.itemcount,
                        ),
                        Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: CustomImageContainer(image: model.data!.images!))),
                        const SizedBox(height: 15,),
                        CustomContainerDetails(
                          id: model.data!.id,
                          name: model.data!.title,
                          price: model.data!.price,
                          rating: 4,
                          image: model.data!.images![0].logo,
                          desc: model.data!.desc,
                          many: cubit.itemCount,
                        )
                      ]),
                ),
              ),
            );
    });
  }
}
