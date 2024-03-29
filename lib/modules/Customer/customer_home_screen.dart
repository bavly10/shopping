import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:myshoop/Cubit/cubit.dart';
import 'package:myshoop/model/language.dart';
import 'package:myshoop/model/product.dart';
import 'package:myshoop/modules/Customer/MyOrders/cubit/cubit.dart';
import 'package:myshoop/modules/Customer/MyOrders/mainOrder.dart';
import 'package:myshoop/modules/Customer/Static/static.dart';
import 'package:myshoop/modules/Customer/cubit/cubit.dart';
import 'package:myshoop/modules/Customer/cubit/state.dart';
import 'package:myshoop/modules/Customer/more/more.dart';
import 'package:myshoop/modules/Customer/MyOrders/widget/newOrderWidget.dart';
import 'package:myshoop/modules/Customer/products/cubit/cubit.dart';
import 'package:myshoop/modules/Customer/products/cubit/states.dart';
import 'package:myshoop/modules/Customer/products/updateProduct.dart';
import 'package:myshoop/modules/Customer/update_customer/update_Customer.dart';
import 'package:myshoop/modules/mainScreen/mainScreen.dart';
import 'package:myshoop/modules/onBoarding/onBoarding_screen.dart';
import 'package:myshoop/shared/compononet/LoagingDialog.dart';
import 'package:myshoop/shared/compononet/MyCachedNetworkImage.dart';
import 'package:myshoop/shared/compononet/componotents.dart';
import 'package:myshoop/shared/compononet/myToast.dart';
import 'package:myshoop/shared/compononet/no_result_search.dart';
import 'package:myshoop/shared/diohelper/dioHelpoer.dart';
import 'package:myshoop/shared/localization/translate.dart';
import 'package:myshoop/shared/my_colors.dart';
import 'package:sizer/sizer.dart';

import 'products/createProduct.dart';
import 'products/details_product/widgets/background_container.dart';

// ignore: must_be_immutable
class CustomerHome extends StatelessWidget {
  var id;
  CustomerHome({Key? key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ProductCubit.get(context).getProducts(context, 1);
    ShopCubit.get(context).getMyShared();
    ProductCubit.get(context).getCategoriesData();
    return BlocConsumer<ProductCubit, ProductStates>(
        listener: (context, state) {
      if (state is LoadingShowCustomer) {
        showDialog(
            context: context, builder: (context) => const LoadingDialog());
      } else if (state is ShowingCustomerData) {
        navigateToFinish(context, UpdateCustomer());
      } else if (state is FailShowCustomerData) {
        myToast(message: mytranslate(context, "noData"));
      } else if (state is GettingProductDataLoading) {
        EasyLoading.showToast("loading..",
            toastPosition: EasyLoadingToastPosition.bottom,
            duration: const Duration(milliseconds: 3));
      } else if (state is GettingStatisticLoading) {
        showDialog(
            context: context, builder: (context) => const LoadingDialog());
      } else if (state is ErrorCat ){
        myToast(message: mytranslate(context, "error"));
      }else{}
    }, builder: (context, state) {
      var productItem = ProductCubit.get(context).listProduct;
      return Scaffold(
        appBar: AppBar(
          leading: SizedBox(),
       actions: [
         IconButton(
           onPressed: (){
             CustomerOrderCubit.get(context).getOrders(context: context, page: CustomerOrderCubit.get(context).limit).then((value) =>
                 navigateTo(context, Orders()));
           },
           icon: const Icon( MdiIcons.cardsHeart,),
           color: myBlue,
           iconSize: 35,
         ),
          InkWell(
            onTap: () {
              ProductCubit.get(context).getLogout(context).whenComplete(
                  () => {navigateToFinish(context,OnBoardingScreen())});
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.logout_rounded,
                color: myBlue,
              ),
            ),
          ),
         const Spacer(),
         DropdownButton(
           onChanged: (lang) {
             DioHelper.init();
             ShopCubit.get(context).changeLang(lang);
           },
           items: lanugage.lang_list
               .map<DropdownMenuItem<lanugage>>(
                   (lang) => DropdownMenuItem(
                 value: lang,
                 child: Row(
                   children: [
                     Text(lang.flag!),
                     const SizedBox(
                       width: 10,
                     ),
                     Text(lang.name!)
                   ],
                 ),
               ))
               .toList(),
           underline: const SizedBox(),
           icon:  Icon(Icons.language,
             color: myBlue,
             size: 30.0,
           ),
         ),
        ]),
        body: RefreshIndicator(
          onRefresh:()async=>await CustomerOrderCubit.get(context).getOrders(context: context,page:0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                  crossAxisAlignment: ShopCubit.xtranslate?CrossAxisAlignment.start:CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   const NewOrderWidget(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: myLinear,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          height:15.h,
                          width: 40.w,
                          child: InkWell(
                            onTap: () {
                              ShopCubit.get(context).getMyShared();
                              ProductCubit.get(context).showCustomerData(ShopCubit.get(context).customerId, context);
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  mytranslate(context, "editdata"),
                                  style: TextStyle(
                                      color: myWhite,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: myLinear,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          height:15.h,
                          width:40.w,
                          child: InkWell(
                            onTap: () {
                              CustomerCubit.get(context)
                                  .getStatisticCustomer(
                                      ShopCubit.get(context).customerId, context)
                                  .then((value) =>
                                      navigateTo(context, StaticMain()));
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  mytranslate(context, "track"),
                                  style: TextStyle(
                                      color: myWhite,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * .90,
                        height: MediaQuery.of(context).size.height * .07,
                        decoration: BoxDecoration(
                            color: myBlue,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20)),
                        child: MaterialButton(
                          onPressed: () {
                            ProductCubit.get(context).imageFileList = [];
                            // ProductCubit.get(context).imageFileList.length = 0;
                            navigateTo(context, CreatePro(id: id,)) ;
                          },
                          child: Text(
                            mytranslate(context, "addpro"),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    Divider(height: 1,color: myBlack,),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            mytranslate(context, "pro"),
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              ProductCubit.get(context).pagnationDataLimit();
                              ProductCubit.get(context)
                                  .getProducts(
                                      context, ProductCubit.get(context).limit)
                                  .then((value) => navigateTo(
                                      context, MoreProductsCustomer()));
                            },
                            child: Text(
                              mytranslate(context, "more"),
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: myBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )),
                      ],
                    ),
                    state is GettingProductDataNull
                        ? const NoResultSearch()
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            reverse: true,
                            itemBuilder: (context, index) {
                              return productItem.isEmpty
                                  ? const NoResultSearch()
                                  : myCard(context: context, pro: productItem[index]);
                            },
                            itemCount: productItem.length)
                  ]),
            ),
          ),
        ),
      );
    });
  }

  Widget myCard({context, required ProductItemMainCustomer pro}) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white, //background color of dropdown button
            border: Border.all(
                color: HexColor("#A7B3CF"),
                width: 1), //border of dropdown button
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .25,
                    height: MediaQuery.of(context).size.height * .10,
                    child: MyCachedNetWorkImage(logo: pro.images![0].logo!,radius:1.0 ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(pro.titleAr!,
                          style: TextStyle(
                            color: HexColor("#A7B3CF"),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: pro.price!,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "WD",
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            Container(
              color: HexColor('#aabbcc'),
              height: 1,
            ),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 10, top: 10.0, left: 20),
                  child: Text("${pro.many!}  ${mytranslate(context, "pic")}",
                      style: const TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold)),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () async {
                      ProductCubit.get(context).imageFileList = [];
                      ProductCubit.get(context).showPro(pro.id, context).then(
                          (value) => {
                            navigateTo(context, UpdateProduct())
                          });
                    },
                    child: Text(
                      mytranslate(context, "editt"),
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: myBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    )),
              ],
            ),

            //  Text(cubit.list[index].)
          ]),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
