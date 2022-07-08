import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(alignment: AlignmentDirectional.centerEnd, children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Image(
              image: AssetImage("assets/x1.png"),
              width: double.infinity,
              height: 100,

              // fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'تيشرت اسود',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        height: 1.4, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text(
                  'يوجد الوان مختلفه',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    height: 1.4,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Text(
              '80.00دينار',
              overflow: TextOverflow.ellipsis,
              // maxLines: 2,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ]),
    );
  }
}
