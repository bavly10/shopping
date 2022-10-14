import 'package:flutter/material.dart';
import 'package:shopping/model/ProductsCustomer.dart';
import 'package:shopping/model/latest_product.dart';
import 'package:shopping/shared/localization/translate.dart';

import '../../../../shared/my_colors.dart';

class LatestPro extends StatelessWidget {
  final ProductsItem productsItem;

  const LatestPro({Key? key, required this.productsItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              height: MediaQuery.of(context).size.height * .05,
              width: MediaQuery.of(context).size.width * .077,
              decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        Image(
          image: NetworkImage(productsItem.image!),
          width:MediaQuery.of(context).size.width * .40,
          height: MediaQuery.of(context).size.height * .15,
           fit: BoxFit.fitWidth,
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
    );
  }
}
