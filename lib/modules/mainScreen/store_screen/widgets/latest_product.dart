import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/model/ProductsCustomer.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/details_product/details_product.dart';
import 'package:shopping/shared/compononet/MyCachedNetworkImage.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/myToast.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:sizer/sizer.dart';


class LatestPro extends StatelessWidget {
  final ProductsItem productsItem;
  const LatestPro({Key? key, required this.productsItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
        return BlocConsumer<ShopCubit,ShopStates>(
          listener: (ctx,state){
            if(state is AppInsertDatabaseState){
              myToast(message:"${productsItem.title} ${mytranslate(context, "donefav")}");
            }else if (state is AppInsertsDatabaseState){
              myToast(message:mytranslate(context, "morefav"));
            }
          },
          builder: (ctx,state){
            final cubit=ShopCubit.get(context);
            return InkWell(
              onDoubleTap: (){},
              onTap: (){
                ProductCubit.get(context).productInfo(productsItem.id, context).then((value) => {navigateTo(context, const DetailsProduct())});
              },
              child: Container(
                margin: const EdgeInsetsDirectional.all(5.0),
                decoration:  BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: myWhite,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height:5.h,
                            width:6.h,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: InkWell(
                                onTap: (){
                                  cubit.insertDatabase(title:productsItem.title!,img:productsItem.image ,price: productsItem.price ,proid:productsItem.id,);
                                },
                                child: const Icon(Icons.favorite,  color: Colors.white, size: 18,),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                        child:  Hero(tag: productsItem.id!,child: MyCachedNetWorkImage(logo: productsItem.image!,radius: 35.0,))
                      ),
                      Text(
                        productsItem.title!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            height: 1.4,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: myBlue),
                      ),
                      const Spacer(),
                      Container(
                        alignment: AlignmentDirectional.bottomCenter,
                        decoration: BoxDecoration(color: myBlue,borderRadius: BorderRadius.circular(5)),
                        padding:const EdgeInsetsDirectional.all(5),
                        child: Text(
                          "${productsItem.price!} ${mytranslate(context, "wd")}",
                          overflow: TextOverflow.ellipsis,
                          // maxLines: 2,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color:myWhite),
                        ),
                      ),
                    ]),
              ),
            );
          },
        );
  }
}
