import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/model/categoryModel.dart';
import 'package:shopping/shared/compononet/MyCachedNetworkImage.dart';
import 'package:shopping/shared/compononet/no_result_search.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:sizer/sizer.dart';

class CategoryScreen extends StatelessWidget {
  TextEditingController? colntroller;
  CategoryScreen({Key? key, this.colntroller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = ShopCubit.get(context).categoryModel;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: SizedBox(
          height: 18.5.h,
          width: double.infinity,
          child: colntroller!.text.isNotEmpty &&
                  ShopCubit.get(context).searchCat.isEmpty
              ? Center(
                  child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .06,
                      child: const Image(
                        image: AssetImage('assets/no.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 12),
                      child: Text(
                        mytranslate(
                          context,
                          "result",
                        ),
                        style: TextStyle(
                            color: myBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ))
              : list!.data!.isEmpty
                  ? Center(child: Text(mytranslate(context, "error")))
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) => Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            width: index == ShopCubit.get(context).selected
                                ? 120
                                : 100,
                            height: index == ShopCubit.get(context).selected
                                ? 160
                                : 120,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: index == ShopCubit.get(context).selected
                                  ? myBlue
                                  : myLightBlue,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: ShopCubit.get(context).searchCat.isEmpty
                                ? buildCate(list.data![index], context, index)
                                : buildCate(
                                    ShopCubit.get(context).searchCat[index],
                                    context,
                                    index)),
                      ),
                      itemCount: ShopCubit.get(context).searchCat.isEmpty
                          ? list.data!.length
                          : ShopCubit.get(context).searchCat.length,
                    )),
    );
  }

  Widget buildCate(CatItem item, context, x) {
    return InkWell(
      onTap: () {
        ShopCubit.get(context).getselected(x);
        ShopCubit.get(context).getCustomerData(item.id!);
      },
      child: Column(
        children: [
          SizedBox(
            height:10.h,
            width: double.infinity,
            child: MyCachedNetWorkImage(logo: item.logo!,radius: 10.0,)
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: Text(
            "${item.title}",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: x == ShopCubit.get(context).selected
                    ? Colors.white
                    : Colors.black87),
          )),
        ],
      ),
    );
  }
}
