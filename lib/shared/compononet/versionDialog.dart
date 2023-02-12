import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_store/open_store.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:url_launcher/url_launcher.dart';

class VersionDialog extends StatelessWidget {
  final TextStyle _style=const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold);
  const  VersionDialog({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[300],
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      elevation: 0.0,
      content: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(child: Text(mytranslate(context, "nameApp"),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
          const SizedBox(height: 10,),
          Text(mytranslate(context, "ver"),style: _style,),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(onPressed: (){
                OpenStore.instance.open(
                    appStoreId: '284815942', // AppStore id of your app for iOS
                    appStoreIdMacOS: '284815942', // AppStore id of your app for MacOS (appStoreId used as default)
                    androidAppBundleId: 'com.facebook.katana&hl=en', // Android app bundle package name
                );
              }, child: Text(mytranslate(context, "updatever"),style: _style,)),
              TextButton(onPressed: (){
                pop();
              }, child: Text(mytranslate(context, "cacnel"),style: _style,)),
            ],
          ),
        )
        ],
      ),
    );
  }
  static Future<void> pop({bool? animated}) async {
    await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop', animated);
  }
  _launchURL(String url) async {
    if (await canLaunchUrl(Uri(path: url))) {
      await _launchURL(url);
    }
    else {
      throw 'Could not launch $url';
    }
  }
}
