import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/model/shippingcompanies.dart';
import 'package:shopping/shared/compononet/blueButton.dart';
import 'package:shopping/shared/my_colors.dart';

class ShippingCompany extends StatelessWidget {
  const ShippingCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        return Scaffold(
          backgroundColor: myGrey,
          body: SafeArea(child: ListView.separated(
              itemBuilder: (context, index) =>myCard( CompanyShipping.company[index]),
              separatorBuilder: (context, index) =>
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey[300],
                  ),
              itemCount:CompanyShipping.company.length)),
        );
      },
    );
  }
  Widget myCard(CompanyShipping x){
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
                SizedBox(
                  width: 140,height:150,
                  child: CachedNetworkImage(
                    imageUrl: x.img!,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,),
                      ),
                    ),
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
               const SizedBox(width:25,),
                Padding(
                  padding: const EdgeInsets.only(top:55.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(x.title!),
                      Text(x.location!),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 160,
                  child: Column(
                    children: [
                      const Text("mawk3 rasmy"),
                      Spacer(),
                     TextButton(onPressed: (){}, child: Container(
                       width:80,
                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(35),color: myBlue),
                       child: Center(child: Text("Connect",style: TextStyle(color: myWhite,fontWeight: FontWeight.bold),),),
                     ))
                    ],
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
