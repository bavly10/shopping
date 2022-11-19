import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/cubit/states.dart';
import 'package:shopping/modules/cart/cart.dart';
import 'package:shopping/shared/compononet/LoagingDialog.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/myToast.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit,ProductStates>(
      builder: (ctx,state){
        final cubit=ProductCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width:MediaQuery.of(context).size.width*.80,
            margin: const EdgeInsetsDirectional.all(15.0),
            padding: const EdgeInsetsDirectional.all(8.0),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25.0) ,
                ),
                color: myBlue
            ),
            child: Row(
              children: [
                Text(mytranslate(context, "cartMS"),style: TextStyle(color: myWhite,fontWeight: FontWeight.w500,fontSize: 17),),
                Container(margin: const EdgeInsetsDirectional.all(4.0),height: 30,width: 1,color: myWhite,),
                const Spacer(),
                InkWell(
                  onDoubleTap: (){},
                  onTap: () {
                    navigateToFinish(context, CartScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Badge(
                      animationDuration: const Duration(milliseconds: 300),
                      position: BadgePosition.topEnd(top: -13),
                      animationType: BadgeAnimationType.fade,
                      showBadge: true,
                      toAnimate: true,
                      shape: BadgeShape.circle,
                      badgeColor: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      badgeContent: //  if (x != 0)
                      Text(
                        "${cubit.itemcount}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize:14,
                            fontWeight: FontWeight.bold),
                      ),
                      child: Icon(
                       MdiIcons.cartArrowDown,
                        color: myWhite,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
