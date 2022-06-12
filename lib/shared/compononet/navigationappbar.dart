import 'package:flutter/material.dart';
import 'package:shopping/shared/my_colors.dart';

class MyNavigationBar extends StatelessWidget {
  late int index;
  late String lable0,lable1,lable2,lable3;
  late Function onTap;
  late IconData iconData0,iconData1,iconData2,iconData3;
  MyNavigationBar({Key? key,required this.index,required this.onTap,required this.iconData0,required this.iconData1,required this.iconData2,required this.iconData3,required this.lable0,required this.lable1,required this.lable2,required this.lable3}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration:  BoxDecoration(
        color: myWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(45.0))
      ),
      child: BottomNavigationBar(
        elevation:0.0,
        backgroundColor: Colors.transparent,
        selectedLabelStyle: TextStyle(color: myBlue),
        selectedFontSize: 18,
        iconSize: 25,
        selectedItemColor: myBlue,
        showUnselectedLabels: true,
        unselectedLabelStyle: TextStyle(color: myBlack),
        unselectedFontSize: 17,
        unselectedItemColor: Colors.grey,
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(label: lable0,icon:Icon(iconData0,),),
          BottomNavigationBarItem(label: lable1,icon:Icon(iconData1),),
          BottomNavigationBarItem(label: lable2,icon:Icon(iconData2,),),
          BottomNavigationBarItem(label: lable3,icon:Icon(iconData3),),
        ],
        onTap: (int tap) {
          onTap(tap);
        },
      ),
    );
  }
}