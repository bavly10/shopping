import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shopping/modules/Customer/products/details_product/widgets/counter.dart';
import 'package:shopping/shared/my_colors.dart';

class CustomContainerDetails extends StatelessWidget {
  String? image;
  String? name;
  dynamic rating;
  dynamic price;
  String? desc;
  CustomContainerDetails(
      {this.image, this.name, this.rating, this.price, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50.0),
          topLeft: Radius.circular(50.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  name.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      wordSpacing: 3,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "48Rates",
                        style: TextStyle(color: Colors.black),
                      ),
                      Spacer(),
                      RatingBar.builder(
                        itemSize: 20,
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: myBlue,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ]),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                desc!,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
                maxLines: 3,
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    const Text("Price",
                        style: TextStyle(
                            color: Colors.black,
                            wordSpacing: 3,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    Spacer(),
                    Text("Quantity",
                        style: TextStyle(
                            color: Colors.black,
                            wordSpacing: 3,
                            fontSize: 15,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              Row(children: [
                Text(
                  ' ${price.toString()} ريال ',
                  style: const TextStyle(
                      color: Colors.black,
                      wordSpacing: 3,
                      fontSize: 15,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomHorizCounterContainer(
                      counter: 3,
                      upward: () {},
                      downrd: () {},
                    ))
              ]),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .5,
                height: 50,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: myBlue,
                  onPressed: () {},
                  child: Text(
                    'اطلب الان',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        letterSpacing: 2,
                        fontFamily: 'Cairo'),
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              )

              // Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
