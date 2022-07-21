import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/model/ProCustomer.dart';
import 'package:shopping/modules/mainScreen/screen/singleCustomerProduct/mainCustomer.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/my_colors.dart';

class CustomerScreen extends StatelessWidget {
  CustomerScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final prosCustomerModel = ShopCubit.get(context).prosCustomerModel;
    return SizedBox(
      height: MediaQuery.of(context).size.height * .9,
      width: double.infinity,
      child: GridView.custom(
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            pattern: [
              const WovenGridTile(12 / 16, crossAxisRatio: .9),
              const WovenGridTile(
                12 / 16,
                crossAxisRatio: .9,
                //alignment: AlignmentDirectional.bottomE,
              ),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) =>
                myCard(prosCustomerModel!.data![index], context),
            childCount: prosCustomerModel!.data!.length,
          )),
    );
  }
  //myCard(prosCustomerModel.data![index],context),

  Widget myCard(ProCustomer pro, context) {
    return InkWell(
      onTap: () {
        print(pro.name!);
        navigateTo(
            context,
            MainCustomer(
              id: pro.id!,
              title: pro.name!,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.height * 0.25,
              child: CachedNetworkImage(
                imageUrl: pro.logo!,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(45.0),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.grey,
                borderRadius: BorderRadius.circular(45.0),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width * .38,
              left: 10,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height * .08,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Text(
                          pro.name!,
                          style: TextStyle(
                              color: myBlue,
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
                            color: Colors.black54,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            pro.address!,
                            style: TextStyle(
                                color: myBlack,
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
            ),
          ],
        ),
      ),
    );
  }
}
