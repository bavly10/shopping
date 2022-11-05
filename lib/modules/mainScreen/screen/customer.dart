import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/model/ProCustomer.dart';
import 'package:shopping/modules/mainScreen/store_screen/main_Store_screen.dart';
import 'package:shopping/shared/compononet/MyCachedNetworkImage.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/custom_rating.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class CustomerScreen extends StatelessWidget {
  CustomerScreen({Key? key}) : super(key: key);
  Color color=myBlue;
  @override
  Widget build(BuildContext context) {
    final prosCustomerModel = ShopCubit.get(context).prosCustomerModel!;
    return  prosCustomerModel.data!.isEmpty? Text(mytranslate(context, "error")):SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child :GridView.custom(
        physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing:16,
            crossAxisSpacing:2,
            pattern: [
              const WovenGridTile(13 / 24, crossAxisRatio: .7),
              const WovenGridTile(13 / 24, crossAxisRatio: .7,
              ),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) =>
                myCard(prosCustomerModel.data![index], context),
            childCount: prosCustomerModel.data!.length,
          )),
    );
  }

  Widget myCard(ProCustomer pro, context) {
    return InkWell(
      onDoubleTap: () {},
      onTap: () {
        navigateTo(context, StoreScreen(
          long: pro.longitude,
                id: pro.id,
                title: pro.name,
                image: pro.logo,
                adress: pro.address,
                phone: pro.phone,
                rate: pro.rate));
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(35.0),
        ),
        width:25.h,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomRating(
                rate: pro.rate,
                star: myWhite,
              ),
            ),
            SizedBox(
              height:22.h,
              width: double.infinity,
              child: MyCachedNetWorkImage(logo: pro.logo!,radius: 35.0,)
            ),
            Text(
              pro.name,
              style: TextStyle(
                  color: myWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
