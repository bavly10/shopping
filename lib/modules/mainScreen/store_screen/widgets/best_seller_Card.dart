import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/model/latest_product.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/details_product/details_product.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/myToast.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:sizer/sizer.dart';

class BestCard extends StatelessWidget {
  LatestProductItem? pro;
  var list, index;

  BestCard({Key? key, this.pro, this.list, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit,ShopStates>(
      builder: (ctx, state) {
        final cartHeart=ShopCubit.get(context).cartHeart;
        return InkWell(
          onDoubleTap: () {},
          onTap: () {
            ProductCubit.get(context)
                .productInfo(list[index].id, context)
                .then((value) => {navigateTo(context, const DetailsProduct())});
          },
          child: Card(
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: SizedBox(
                  height: 20.h,
                  child: Image(
                    image: NetworkImage(pro!.image!),
                  ),
                ),
              ),
              Text(
                pro!.title!,
                style:
                    const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 5.h,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10)),
                      child: IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeCart(index);
                          ProductCubit.get(context).additem(
                              proid: pro!.id.toString(),
                              imgurl: pro!.image.toString(),
                              title: pro!.title.toString(),
                              size: ProductCubit.get(context)
                                  .selectSize
                                  .toString(),
                              price: double.parse(pro!.price!),
                              qua: ProductCubit.get(context).itemCount);
                          myToast(message: "${pro!.title} Is Added ");
                        },
                        icon: const Icon(Icons.badge_rounded),
                        color: cartHeart==index?Colors.red:Colors.white,
                        iconSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${pro!.price!} ${mytranslate(context, "wd")}",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        );
      },
    );
  }
}
