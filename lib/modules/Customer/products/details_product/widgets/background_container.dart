import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:sizer/sizer.dart';

class CustomBackgroundContainer extends StatelessWidget {
  void Function()? arrowBack;
  void Function()? cartShopping;
  int? x;
  CustomBackgroundContainer({this.arrowBack, this.cartShopping, this.x});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      color: myGrey,
      height:10.h,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, right: 3, left: 10),
        child: Row(
          children: [
            MaterialButton(
              onPressed: arrowBack,
              color: myBlue,
              textColor: Colors.white,
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                size: 24,
              ),
              padding: const EdgeInsets.all(8),
              shape: const CircleBorder(),
            ),
            const Spacer(),
            InkWell(
              onDoubleTap: (){},
              onTap: cartShopping,
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
                    x.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: myBlue,
                    size: 35,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
