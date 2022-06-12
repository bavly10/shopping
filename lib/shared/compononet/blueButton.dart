import 'package:flutter/material.dart';
import 'package:shopping/shared/my_colors.dart';

class BlueButton extends StatelessWidget {
  final String title;
  final double hight,width;
  final Function onpress;
   IconData? icon;
   BlueButton({Key? key, required this.title,required this.onpress,required this.hight,required this.width,this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextButton(
        onPressed:()=>onpress(),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(45.00),color: myBlue),
          height: MediaQuery.of(context).size.height*hight,
          width: MediaQuery.of(context).size.width*width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon!=null)
                    Icon(
                      icon,
                      color: myWhite,
                    ),
                Padding(
                  padding: const EdgeInsets.only(right:20),
                  child: Text(title,style: TextStyle(color: myWhite,fontSize: 18,fontWeight: FontWeight.bold,),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
