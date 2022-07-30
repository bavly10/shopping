import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shopping/shared/my_colors.dart';

class CustomBackgroundContainer extends StatelessWidget {
  void Function()? arrowBack;
  void Function()? cartShopping;
  int? x;
  CustomBackgroundContainer({this.arrowBack, this.cartShopping,this.x});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      color: myGrey,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
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
          child: Stack(
            children:[
              const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black87,
                size: 45,
              ),
             if(x!=0)Container(
                padding: EdgeInsets.only(bottom: 9),
                height: 45,width: 25,
                decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(12.0)),
                child: Center(child: Text(x.toString(),style: const TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)),
              ),
            ],
          ),
        )
          ],
        ),
      ),
    );
  }
}
