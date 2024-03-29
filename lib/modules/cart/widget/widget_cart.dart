import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myshoop/modules/Customer/products/cubit/cubit.dart';
import 'package:myshoop/shared/localization/translate.dart';
import 'package:sizer/sizer.dart';

import '../../../shared/my_colors.dart';

class Cartitemapp extends StatelessWidget {
  final String id, proid, title, imgurl, size;
  String? rate;
  final int quant;
  final double price;
  Cartitemapp(
      {required this.id,
      required this.proid,
      required this.title,
      required this.imgurl,
      required this.size,
      required this.quant,
      required this.price,
      this.rate});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return getMyDialog(context);
          },
        );
      },
      background: Container(
        color: Colors.red,
        child: Row(
          children: [
            Text(mytranslate(context, "deleteemoj"),style: TextStyle(color: myWhite,fontWeight: FontWeight.w600),),
            const Spacer(),
            Icon(Icons.delete,color: myWhite,),
          ],
        ),
      ),
      key: Key(id),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Card(
          elevation: 2,
          color: myWhite,
          margin: const EdgeInsets.symmetric(vertical: 2),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(backgroundImage:NetworkImage(imgurl) ,radius: 6.6.h,),
                    SizedBox(width: 5.w),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${mytranslate(context, "price")}:  $price",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                  fontSize: 15),
                            ),
                            Row(
                              children: [
                                Text(
                                  mytranslate(context, "totals"), style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w600, fontSize: 15),
                                ),
                                Text(
                                  "${price * quant}",
                                  style: const TextStyle(
                                      color: Colors.lightBlue, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(height: 4.h,),
                        SizedBox(
                     width: MediaQuery.of(context).size.width * .23,
                     height: MediaQuery.of(context).size.height * .05,
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Expanded(child: Container(
                           decoration: BoxDecoration(
                             color: myBlue,
                               border: Border.all(color: myBlue),
                               borderRadius: BorderRadius.circular(10)),
                           child: InkWell(
                             child: Center(
                               child: Icon(
                                 Icons.add,
                                 size: 22,
                                 color: myWhite,
                               ),
                             ),
                             onTap: () {
                               ProductCubit.get(context).additem(
                                   proid: proid,
                                   imgurl: imgurl,
                                   title: title,
                                   price: price,
                                   size: size,
                                   qua: quant);
                             },
                           ),
                         )),
                         Padding(
                           padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                           child: Text(
                             quant.toString(),
                             style: TextStyle(
                               color: myBlue,
                               fontWeight: FontWeight.bold,
                               fontSize: 18,
                             ),
                           ),
                         ),
                         Expanded(
                           child: InkWell(
                             onTap: () {
                               ProductCubit.get(context).removesingleitem(proid);
                             },
                             child: Container(
                               decoration: BoxDecoration(
                                 color: myBlacks,
                                   borderRadius: BorderRadius.circular(10)),
                               child: Center(
                                 child: Icon(
                                  MdiIcons.minus,
                                   size: 22,
                                   color: myWhite,
                                 ),
                               ),
                             ),
                           ),
                         ),
                       ],
                     ),
                        ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  AlertDialog getMyDialog(context){
    return AlertDialog(
      title:  Text(mytranslate(context, "confirmDialog")),
      content: Text(mytranslate(context, "msgDialog")),
      actions: <Widget>[
        TextButton(
            onPressed: (){
              ProductCubit.get(context).removeitem(proid);
              Navigator.of(context).pop(true);
            },
            child:  Text(mytranslate(context, "deleteDialog"))
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(mytranslate(context, "cacnel")),
        ),
      ],
    );
  }
}
