import 'package:flutter/material.dart';
import 'package:shopping/shared/compononet/arrowBack.dart';
import 'package:shopping/shared/compononet/blueButton.dart';
import 'package:shopping/shared/my_colors.dart';


class CartScreen extends StatelessWidget {
   double x=0.0;
  double y = 0.10;
  double d = 30.0;
  @override
  Widget build(BuildContext context) {
    var z = (x * y);
    var totall = (z + x + d);
    return SafeArea(
      child:Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("منتجات",style: TextStyle(color: myBlue,fontSize: 20),),
                const SizedBox(width:20),
                Text("0",style: TextStyle(color: myBlue,fontSize: 20),),
                const Spacer(),
                const Text("My Bag",style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),),
                const SizedBox(width: 5,),
                const Icon(Icons.arrow_forward_ios,size: 35,)
              ],
            ),
            const Expanded(
                child:
                Center(child: Text("Card is Empty",style: TextStyle(fontSize: 25),))
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              color: myLightBlue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                       const Text("Price"),
                        Text("${z.toStringAsFixed(2)} L.E"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       const Text("Shipping"),
                        Text("${z.toStringAsFixed(2)} L.E"),
                      ],
                    ),
                    const  Divider(
                      color: Colors.blueAccent,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total"),
                        Text("${d.toStringAsFixed(2)} L.E"),
                      ],
                    ),
                    BlueButton(title: "Confirm Order", onpress: (){}, hight: 0.07, width: 0.80)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}