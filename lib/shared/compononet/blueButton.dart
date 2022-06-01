import 'package:flutter/material.dart';
import 'package:shopping/shared/my_colors.dart';

class BlueButton extends StatelessWidget {
  final String title;
  final Function onpress;
  const BlueButton({Key? key, required this.title,required this.onpress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextButton(
        onPressed:()=>onpress(),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(45.00),color: myBlue),
          height: MediaQuery.of(context).size.height*0.08,
          width: MediaQuery.of(context).size.width*0.80,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back,color: myWhite,),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: Text(title,style: TextStyle(color: myWhite,fontSize: 18,fontWeight: FontWeight.bold),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
