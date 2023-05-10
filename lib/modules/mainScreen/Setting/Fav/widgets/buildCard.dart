import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshoop/Cubit/cubit.dart';
import 'package:myshoop/modules/Customer/products/cubit/cubit.dart';
import 'package:myshoop/modules/Customer/products/cubit/states.dart';
import 'package:myshoop/modules/Customer/products/details_product/details_product.dart';
import 'package:myshoop/shared/compononet/LoagingDialog.dart';
import 'package:myshoop/shared/compononet/componotents.dart';
import 'package:myshoop/shared/compononet/dialog.dart';
import 'package:myshoop/shared/compononet/myToast.dart';
import 'package:myshoop/shared/localization/translate.dart';
import 'package:myshoop/shared/my_colors.dart';
class BuildCard extends StatelessWidget {
  final Map model;
  const BuildCard({Key? key,required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit,ProductStates>(
      listener: (ctx,state){
        if(state is loadingProduct){
         myToast(message: mytranslate(context, "loading"));
        } else if (state is ShowingProduct ){
       navigateToFinish(context, const DetailsProduct());
        } else if (state is failProduct){
          myToast(message: mytranslate(context, "error"));
        }
        else{}
      },
      child: InkWell(
        onDoubleTap: (){},
        onTap: (){
          ProductCubit.get(context).productInfo(model['idPro'], context);
        },
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 0,
              color: myGrey,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, right: 5),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              My_CustomAlertDialog(
                                  onPress: () => ShopCubit.get(context).deleteDatabase(id: model['id']).then((value) => Navigator.pop(context)),
                                  pressTitle: 'OK',
                                  context: context,
                                  icon: Icons.delete_forever,
                                  bigTitle: mytranslate(context, "nameApp"),
                                  content: mytranslate(context, "del"),
                                  pressColor: Colors.red,
                                  iconColor: Colors.red);

                            },
                            child: Icon(
                              Icons.cancel_sharp,
                              color: myBlue,
                            ),
                          ),
                        ),
                      ),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * .14,
                            width: MediaQuery.of(context).size.width * .16,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(model['img']),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    model['title'],
                                    style: const TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .30,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${mytranslate(context, "pricee")} ${model['price']}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    width: 43,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
