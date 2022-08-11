import 'package:flutter/material.dart';
import 'package:shopping/model/myOrderCustomer.dart';

class EXPTile extends StatelessWidget {
  final DataOrder order;
  const EXPTile({Key? key,required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(8),
      child:ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:[
            Text("${order.userInfo!.name}",style: TextStyle(color: Colors.red),),SizedBox(width: 10,),
            Icon(Icons.star,size: 15,color: Colors.grey,),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.black),child: Text(order.many.toString(),style: TextStyle(color: Colors.white),),),
                const Text(":الكميه"),
              ],
            ),
          ],
        ),
        subtitle: Text(order.total.toString()),
        children: [
          Column(
            children: [
              Row(children: [
                Container(width: 100,height: 100,child: Image.network(order.productOrder!.image!),),
                SizedBox(width: 10,),
                Text(order.productOrder!.title!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),],),
              Text(" السعرالمنتج الواحد: ${order.productOrder!.price}"),
              const Divider(height: 10,color: Colors.blue,),
            ],
          )
        ]
      ),
    );
  }
}
