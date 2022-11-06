import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:shopping/Cubit/cubit.dart';

import 'package:shopping/modules/mainScreen/store_screen/widgets/top_screen.dart';
import 'package:shopping/shared/compononet/connection_dialog.dart';
import 'package:shopping/shared/compononet/myToast.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CustomDrawer extends StatelessWidget {
  String? image, address, phoneStore, rate,long;
  final String tiltle;
  int? id;
  GlobalKey<ScaffoldState>? skey;
  CustomDrawer(
      {Key? key,
      required this.tiltle,
      this.address,
      this.image,
      this.id,
      this.long,
      this.skey,
      this.phoneStore,
      this.rate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).getMyShared();
    return SafeArea(
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        Padding(
          padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
          child: TopScreen(
            title: tiltle,
            image: image,
            star: HexColor('#F89A2F'),
            textColor: Colors.white,
            rate: rate,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 90.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.white,
                size: 33,
              ),
              const SizedBox(width: 10),
              Text(
                address!,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0, bottom: 40),
          child: Center(
              child: Container(
            width: MediaQuery.of(context).size.width * .60,
            height: MediaQuery.of(context).size.height * .080,
            decoration: BoxDecoration(
                color:
                    HexColor('#A7B3CF'), //background color of dropdown button
                border: Border.all(
                    color: HexColor('#A7B3CF'),
                    width: 0), //border of dropdown button
                borderRadius: BorderRadius.circular(
                    20), //border raiuds of dropdown button
                boxShadow: <BoxShadow>[
                  //apply shadow on Dropdown button
                  BoxShadow(color: myBlue, blurRadius: 0.1), //shadow for button
                ]),
            child: InkWell(
              onTap: () {
                if(long!.startsWith("https://goo.gl/maps")){
                  launchUrlString(long!);
                }
              else{
                myToast(message: mytranslate(context, "loca"));
                }
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.map_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      mytranslate(context, "show"),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ),
        Container(
          width: MediaQuery.of(context).size.width * .60,
          height: MediaQuery.of(context).size.height * .080,
          decoration: BoxDecoration(
              color: HexColor('#A7B3CF'), //background color of dropdown button
              border: Border.all(
                  color: HexColor('#A7B3CF'),
                  width: 0), //border of dropdown button
              borderRadius:
                  BorderRadius.circular(20), //border raiuds of dropdown button
              boxShadow: <BoxShadow>[
                //apply shadow on Dropdown button
                BoxShadow(color: myBlue, blurRadius: 0.1), //shadow for button
              ]),
          child: InkWell(
            onTap: () {
              // if (ShopCubit.get(context).userId == null) {
              showDialog(
                  context: skey!.currentContext!,
                  builder: (context) {
                    return ConnectoinDialog(
                      phoneStore: phoneStore,
                    );
                  });
           },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                const SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    mytranslate(context, "mobile"),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
