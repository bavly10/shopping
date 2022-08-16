import 'package:flutter/material.dart';
import 'package:shopping/model/ProductsCustomer.dart';
import 'package:shopping/model/latest_product.dart';

import '../../../../shared/my_colors.dart';

class LatestPro extends StatelessWidget {
  final ProductsItem productsItem;

  const LatestPro({Key? key, required this.productsItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(alignment: AlignmentDirectional.centerEnd, children: [
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Image(
              image: NetworkImage(productsItem.image!),
              width: MediaQuery.of(context).size.width * .33,
              height: MediaQuery.of(context).size.height * .13,

              // fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    productsItem.title!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        height: 1.4,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: myBlue),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  productsItem.desc!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                      height: 1.4, fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Text(
              "${productsItem.price!}WD",
              overflow: TextOverflow.ellipsis,
              // maxLines: 2,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.red[900]),
            ),
          ),
        ),
      ]),
    );
  }
}
