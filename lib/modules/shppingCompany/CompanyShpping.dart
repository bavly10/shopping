import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/model/shippingcompanies.dart';
import 'package:shopping/shared/compononet/blueButton.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../shared/verification_dialog.dart';

class ShippingCompany extends StatelessWidget {
  const ShippingCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        var cubit = ShopCubit.get(context).shippingModel;
        return Scaffold(
            backgroundColor: myGrey,
            body: SafeArea(
                child: cubit != null
                    ? ListView.separated(
                        itemBuilder: (context, index) {
                          return myCard(context, cubit.data![index]);
                        },
                        separatorBuilder: (context, index) => Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey[300],
                            ),
                        itemCount: cubit.data!.length)
                    : const Center(
                        child: CircularProgressIndicator(),
                      )));
      },
    );
  }

  Widget myCard(context, Data shippingModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 3,
                    child: SizedBox(
                      width: 250,
                      height: 150,
                      child: CachedNetworkImage(
                        imageUrl: shippingModel.logo!,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 55.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          shippingModel.title!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: myBlue),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(shippingModel.desc!)
                      ],
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    flex: 3,
                    child: SizedBox(
                      height: 160,
                      child: Column(
                        children: [
                          InkWell(
                              onTap: () {
                                navigateTo(
                                    context,
                                    InAppWebView(
                                        initialUrlRequest: URLRequest(
                                            url: Uri.parse(
                                                shippingModel.link!))));
                              },
                              child: Text(
                                "الموقع الرسمي",
                                style: TextStyle(
                                    color: myBlue,
                                    decoration: TextDecoration.underline,
                                    decorationStyle: TextDecorationStyle.solid),
                              )),
                          Spacer(),
                          TextButton(
                              onPressed: () {},
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          CustomDialog(
                                            text: mytranslate(context, "note"),
                                          ));
                                },
                                child: Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                      color: myBlue),
                                  child: Center(
                                    child: Text(
                                      mytranslate(context, "connect"),
                                      style: TextStyle(
                                          color: myWhite,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
