import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myshoop/shared/my_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;

class CustomBackgroundContainer extends StatelessWidget {
  void Function()? arrowBack;
  void Function()? cartmyshoop;
  int? x;
  CustomBackgroundContainer({this.arrowBack, this.cartmyshoop, this.x});
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
              onTap: cartmyshoop,
              child:  badges.Badge(
                badgeContent:
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(shape: BoxShape.circle,color: myWhite),
                          child: Text(
                            x.toString(),
                            style:  TextStyle(
                                color: myBlue,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Icon(Icons.add_shopping_cart_outlined, color: Colors.black, size: 25),
                      ],
                    ),
                badgeAnimation: const badges.BadgeAnimation.rotation(
                  animationDuration: Duration(seconds:2),
                  curve: Curves.fastOutSlowIn,
                ),
                badgeStyle: badges.BadgeStyle(
                  shape: badges.BadgeShape.circle,
                  padding: EdgeInsets.all(5),
                  badgeColor: myBlue,
                  borderRadius: BorderRadius.circular(4),
                  elevation: 0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
