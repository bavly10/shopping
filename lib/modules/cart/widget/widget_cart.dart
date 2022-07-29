import 'package:flutter/material.dart';
import 'package:shopping/modules/Customer/products/cubit/cubit.dart';
class Cartitemapp extends StatelessWidget {
  final String id,proid,title,imgurl;
  final int quant;
  final double price;
  const Cartitemapp({required this.id,required this.proid,required this.title,required this.imgurl,required this.quant,required this.price});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Card(
          elevation: 6,
          margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 4),
          child: Padding(
              padding: const EdgeInsets.all(8),
              child:Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: NetworkImage(imgurl))),
                      ),
                      Text("$title",style: TextStyle(fontSize: 18),),
                      const Spacer(),
                      IconButton(icon: const Icon(Icons.add_circle_sharp,color: Colors.lightBlue),
                          onPressed: ()=>ProductCubit.get(context).additem(proid: proid,imgurl:  imgurl,title:  title, price: price, qua:quant )),
                      Text("$quant"),
                      IconButton(icon: const Icon(Icons.remove_circle,color: Colors.red,),
                          onPressed: ()=>ProductCubit.get(context).removesingleitem(proid)),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    children: [
                      Text("Price is:$price"),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Text("Total is: ${price*quant}",style: const TextStyle(
                      color: Colors.lightBlue
                  ),)
                ],
              )
          ),
        ),
      ],
    );
  }
}