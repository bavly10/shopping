import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/model/ProCustomer.dart';
import 'package:shopping/modules/Customer/singleCustomerProduct/mainCustomer.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/my_colors.dart';

class CustomerScreen extends StatelessWidget {
   CustomerScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final prosCustomerModel=ShopCubit.get(context).prosCustomerModel;
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: MasonryGridView.count(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        mainAxisSpacing: 150,
        crossAxisSpacing: 3,
        itemCount:  prosCustomerModel!.data!.length,
        crossAxisCount: 2,
        itemBuilder: (context, index) =>myCard(prosCustomerModel.data![index],context),
      ),
    );
  }
  Widget myCard(ProCustomer pro,context){
    return InkWell(
      onTap:(){
        print(pro.name!);
        navigateTo(context,  MainCustomer(id: 4,title: pro.name!,));
      } ,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*0.35,
              width: 250,
              child: CachedNetworkImage(
                imageUrl: pro.logo!,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45.0),
                    image: DecorationImage(
                        image: imageProvider),
                  ),
                ),
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Container(
              width:  MediaQuery.of(context).size.width*0.44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Column(
                children: [
                  Text(pro.name!,style: const TextStyle(color: Colors.black87,fontSize: 20),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_pin,size: 20,color: myBlack,),
                      const SizedBox(width: 5,),
                      Text(pro.address!)
                    ],)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
