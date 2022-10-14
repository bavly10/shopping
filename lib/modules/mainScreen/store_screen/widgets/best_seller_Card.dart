import 'package:flutter/material.dart';
import 'package:shopping/model/latest_product.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/details_product/details_product.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/localization/translate.dart';

import '../../../../model/ProductsCustomer.dart';

class BestCard extends StatelessWidget {
  LatestProductItem? pro;
  var list,index;
  BestCard({Key? key, this.pro,this.list,this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
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
        child: Container(
          width: MediaQuery.of(context).size.width * .20,
          height: MediaQuery.of(context).size.width * .9,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 120,
                width: 500,
                child: Image(
                  image: NetworkImage(pro!.image!),
                ),
              ),
            ),
            Text(
              pro!.title!,
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .06,
                    width: MediaQuery.of(context).size.width * .089,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Icon(
                        Icons.badge_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${pro!.price!}\n${mytranslate(context, "wd")}',
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
