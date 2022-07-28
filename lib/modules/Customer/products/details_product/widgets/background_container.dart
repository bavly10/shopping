import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shopping/shared/my_colors.dart';

class CustomBackgroundContainer extends StatelessWidget {
  void Function()? arrowBack;
  void Function()? cartShopping;

  CustomBackgroundContainer({this.arrowBack, this.cartShopping});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      color: myGrey,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 45, right: 15, left: 15),
        child: Row(
          children: [
            InkWell(
              onTap: arrowBack,
              child: CircleAvatar(
                backgroundColor: myBlue,
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: cartShopping,
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black87,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
