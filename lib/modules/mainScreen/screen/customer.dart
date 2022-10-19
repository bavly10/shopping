import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/model/ProCustomer.dart';
import 'package:shopping/modules/mainScreen/screen/Welcomebage.dart';
import 'package:shopping/modules/mainScreen/store_screen/main_Store_screen.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/no_result_search.dart';
import 'package:shopping/shared/my_colors.dart';

class CustomerScreen extends StatelessWidget {
  CustomerScreen({Key? key}) : super(key: key);
  Color color=myBlue;
  @override
  Widget build(BuildContext context) {
    final prosCustomerModel = ShopCubit.get(context).prosCustomerModel;
    return  prosCustomerModel==null?  const Welcome():SizedBox(
      height: MediaQuery.of(context).size.height *0.16,
      width: double.infinity,
      child :GridView.custom(
        physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing:12,
            crossAxisSpacing:2,
            pattern: [
              const WovenGridTile(13 / 22, crossAxisRatio: .7),
              const WovenGridTile(13 / 22, crossAxisRatio: .7,
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
                id: pro.id,
                title: pro.name,
                image: pro.logo,
                adress: pro.address,
                phone: pro.phone,
                rate: pro.rate));
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: color,
          borderRadius: BorderRadius.circular(35.0),
        ),
        width: MediaQuery.of(context).size.height * 0.25,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*0.22,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: pro.logo!,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color:myWhite,
                    borderRadius: BorderRadius.circular(35.0),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.height * .08,
                decoration: BoxDecoration(
                  color:color,
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        pro.name,
                        style: TextStyle(
                            color: myWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Icon(
                          Icons.location_pin,
                          size: 20,
                          color: myWhite,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          pro.address!,
                          style: TextStyle(
                              color: myWhite,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 14),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
