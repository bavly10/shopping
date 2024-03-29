import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myshoop/modules/Customer/login/cubit/cubit.dart';
import 'package:myshoop/modules/Customer/login/cubit/state.dart';
import 'package:myshoop/shared/compononet/textField.dart';
import 'package:myshoop/shared/localization/translate.dart';
import 'package:myshoop/shared/my_colors.dart';
import 'package:myshoop/shared/strings.dart';

class SecondScreen extends StatelessWidget {
   SecondScreen({Key? key}) : super(key: key);
   static TextEditingController mobilecontroller=TextEditingController();
   static TextEditingController AdressController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit,LoginStates>(
     builder: (ctx,state){
       final cubit=LoginCubit.get(context);
       return Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           MyTextField(validate: (String? s) {
             if (s!.isEmpty) return mytranslate(context, "validateNumber");
           },  readonly: false,label:mytranslate(context,"mobile"),controller: mobilecontroller,prefix: Icons.account_circle,type: TextInputType.phone, obcure: false,),
           const SizedBox(height: 25,),
           DropdownButton(
             hint: cubit.mycity == null
                 ? Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('${mytranslate(context, "address")} ',
                   style: TextStyle(
                       color: myBlue,
                       fontWeight: FontWeight.bold)),
             )
                 : Padding(
               padding: const EdgeInsets.all(2.0),
               child: Text(cubit.mycity!,
                   style: TextStyle(
                       color: myBlue,
                       fontSize: 14,
                       fontWeight: FontWeight.bold)),
             ),
             underline: const SizedBox(),
             icon: Icon(
               Icons.keyboard_arrow_down_sharp,
               color: myBlue,
               size: 35,
             ),
             items: suaid
                 .map<DropdownMenuItem<String>>(
                     (spec) => DropdownMenuItem(
                   value: spec,
                   child: Text(spec),
                 ))
                 .toList(),
             onChanged: (val) {
               cubit.changeSelectCity(val);
             },
           ),
           const SizedBox(height: 25,),
           MyTextField(validate: (String? s) {
             if (s!.isEmpty) return mytranslate(context, "location");
           },  readonly: false,label:mytranslate(context,"location"),controller: AdressController,prefix: Icons.account_circle,type: TextInputType.url, obcure: false,),
         ],
       );
     },
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
            Text(mytranslate(context,"map")),
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