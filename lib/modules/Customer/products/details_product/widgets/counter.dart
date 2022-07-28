import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopping/shared/my_colors.dart';

class CustomHorizCounterContainer extends StatelessWidget {
  void Function()? upward;
  void Function()? downrd;
  dynamic counter;
  CustomHorizCounterContainer(
      {required this.upward, required this.downrd, required this.counter});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 150,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(color: myGrey!),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: InkWell(
            child: Icon(
              Icons.add,
              size: 22,
              color: HexColor("#707070"),
            ),
            onTap: upward,
          )),
          Text(
            counter.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: InkWell(
              child: Icon(
                Icons.minimize,
                size: 22,
                color: HexColor("#707070"),
              ),
              onTap: downrd,
            ),
          ),
        ],
      ),
    );
  }
}
