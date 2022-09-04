import 'package:flutter/material.dart';
import 'package:shopping/modules/Customer/MyOrders/cubit/cubit.dart';

import '../../../../shared/my_colors.dart';

class PagesContainer extends StatelessWidget {
  int? index;

  PagesContainer({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomerOrderCubit.get(context).getselected(index!);
        CustomerOrderCubit.get(context).getOrders(
            context: context, page: CustomerOrderCubit.get(context).limit);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: index == CustomerOrderCubit.get(context).selected ? 40 : 20,
        width: index == CustomerOrderCubit.get(context).selected ? 40 : 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: index == CustomerOrderCubit.get(context).selected ? myBlue : myGrey,
          border: Border.all(color: Colors.grey[200]!),
          // color: myGrey,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Container(
            child: Text(
          CustomerOrderCubit.get(context).pages[index!].toString(),
          style: TextStyle(
              color: index == CustomerOrderCubit.get(context).selected
                  ? Colors.white
                  : myBlue,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        )),
      ),
    );
  }
}
