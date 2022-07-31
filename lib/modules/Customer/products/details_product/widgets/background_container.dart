import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shopping/shared/my_colors.dart';

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
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 15,
          right: 15,
        ),
        child: Row(
          children: [
            InkWell(
                onTap: arrowBack,
                child: MaterialButton(
                  onPressed: () {},
                  color: myBlue,
                  textColor: Colors.white,
                  child: const Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 24,
                  ),
                  //
                  //
                  padding: EdgeInsets.all(8),
                  shape: CircleBorder(),
                )

                // CircleAvatar(
                //   radius: 22,
                //   backgroundColor: myBlue,
                //   child: const Center(
                //     child: Icon(
                //       Icons.arrow_back_ios,
                //       color: Colors.white,
                //       size: 19,
                //     ),
                //   ),
                // ),
                ),
            const Spacer(),
            InkWell(
              onTap: cartShopping,
              child: Badge(
                animationDuration: Duration(milliseconds: 300),
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
                  size: 40,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
