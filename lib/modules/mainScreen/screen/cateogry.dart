import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/model/categoryModel.dart';
import 'package:shopping/shared/my_colors.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = ShopCubit.get(context).categoryModel;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child:SizedBox(
        height:MediaQuery.of(context).size.height*0.16,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx,index)=> Padding(
            padding: const EdgeInsets.all(6.0),
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: index == ShopCubit.get(context).selected ? 105 : 80,
                height: index == ShopCubit.get(context).selected ? 80 : 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: index == ShopCubit.get(context).selected ? myBlue : Colors.grey,
                  borderRadius: BorderRadius.circular(25.0),),
                child: buildCate(list!.data![index],context,index)),
          ),
          itemCount: list!.data!.length,),
      ),
    );
  }

  Widget buildCate(CatItem item,context,x) {
    return InkWell(
      onTap: (){
        ShopCubit.get(context).getselected(x);
         ShopCubit.get(context).getCustomerData(item.id);
        print(item.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              width:100,
              child: CachedNetworkImage(
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fitWidth,),
                  ),
                ),
                imageUrl: "${item.logo}",
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(child: Text("${item.title}",style:  TextStyle(fontSize: 14,fontWeight: FontWeight.bold,
                color:x==ShopCubit.get(context).selected? Colors.white : Colors.black87),)),
          ],
        ),
      ),
    );
  }
}
