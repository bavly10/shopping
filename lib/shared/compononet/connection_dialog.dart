import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shopping/shared/compononet/myToast.dart';

import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectoinDialog extends StatelessWidget {
  void Function()? onTap;
  String? phoneStore;
  String? text;
  String? btnName;
  ConnectoinDialog(
      {Key? key, this.onTap, this.text, this.btnName, this.phoneStore})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            // height: 250,
            padding: const EdgeInsets.only(
              top: 18.0,
            ),
            margin: const EdgeInsets.only(top: 13.0, right: 8.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(mytranslate(context, "selecte"),
                      style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                ) //
                    ),
                const SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    children: [
                      InkWell(
                          child: Container(
                              width: 100,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: myBlue,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    topRight: Radius.circular(16.0),
                                    bottomLeft: Radius.circular(16.0),
                                    bottomRight: Radius.circular(16.0)),
                              ),
                              child: Icon(
                                MdiIcons.phone,
                                size: 25,
                                color: myWhite,
                              )),
                          onTap: () => launch('tel:$phoneStore')),
                      const Spacer(),
                      InkWell(
                          child: Container(
                              width: 100,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.green[400],
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    topRight: Radius.circular(16.0),
                                    bottomLeft: Radius.circular(16.0),
                                    bottomRight: Radius.circular(16.0)),
                              ),
                              child: const Icon(MdiIcons.whatsapp,
                                  size: 26, color: Colors.white)),
                          onTap: () async {
                            var whatsappUrl =
                                "whatsapp://send?phone=$phoneStore";
                            await canLaunch(whatsappUrl)
                                ? launch(whatsappUrl)
                                : myToast(
                                    message: mytranslate(context, "what"));
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: myBlue,
                  child: const Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
