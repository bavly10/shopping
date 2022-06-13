import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shopping/shared/compononet/textField.dart';
import 'package:shopping/shared/my_colors.dart';

class SecondScreen extends StatelessWidget {
   SecondScreen({Key? key}) : super(key: key);
  TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyTextField(label: "Mobile Number",controller: controller,prefix: Icons.account_circle,type: TextInputType.text, obcure: false,),
        const SizedBox(height: 25,),
        MyTextField(label: "Address",controller: controller,prefix: Icons.account_circle,type: TextInputType.text,obcure: false),
        const SizedBox(height: 25,),
        location(context)

      ],
    );
  }
  Widget location(context){
    return InkWell(
      onTap: (){},
      child: Container(
        width: MediaQuery.of(context).size.width*0.80,
        height: MediaQuery.of(context).size.height*0.06,
        decoration: BoxDecoration(color: myBlacks,borderRadius: BorderRadius.circular(45.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Icon(MdiIcons.plusCircle,size: 30,color: myBlue,),
           ),
           const Text("Add your store location on the map"),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Icon(MdiIcons.mapMarker,size: 30,color: myBlue,),
           )
          ],
        ),
      ),
    );
  }
}