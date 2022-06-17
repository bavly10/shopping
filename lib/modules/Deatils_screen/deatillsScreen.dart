import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/shared/compononet/arrowBack.dart';
import 'package:shopping/shared/compononet/blueButton.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class DetailsScreen extends StatelessWidget {
   DetailsScreen({Key? key}) : super(key: key);
  List image=[
    'assets/x1.png',
    'assets/x2.png',
    'assets/x3.png',
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (ctx,state){},
      builder: (ctx,state) {
        final cubit=ShopCubit.get(context);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                myAppBar(),
                myCarsoula(image,context),
                myIndicator(image,context),
                myDescription(title: "سويتشرت رجالي",color: "ازرق",model: "129037991"),
                anotherRow(2,25),
                myFinalRow("x2")
              ],
            ),
          ),
        );
      }
    );
  }
  Widget myAppBar(){
    return Row(
      children: [
        const Icon(Icons.add_shopping_cart_sharp),
       const Spacer(),
        MyArrowBack(onPress: (){}),
      ],
    );
  }
  Widget myCarsoula(List imglist,context){
    return  SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.35,
      child: CarouselSlider(
          carouselController: CarouselControllerImpl(),
          items: imglist.map((e) => Container(decoration: BoxDecoration(image: DecorationImage(
            image: ExactAssetImage(e.toString()),fit:BoxFit.fitHeight
          ),borderRadius: BorderRadius.circular(45.0)),
          )).toList(),
          options: CarouselOptions(
              enableInfiniteScroll: true,
              viewportFraction: 1.0,
              onPageChanged: (int i, _) {
                ShopCubit.get(context).getDetailsIndex(i);
              },
              autoPlayInterval: const Duration(seconds: 2),
              enlargeCenterPage: true,
              initialPage: 0,
              autoPlay: true,
              scrollDirection: Axis.horizontal)),
    );
  }
   Widget myIndicator(List image,context) {
     return Align(
       alignment: Alignment.center,
       child:SizedBox(
         width: MediaQuery.of(context).size.width*0.20,
         height:  MediaQuery.of(context).size.height*0.02,
         child: ListView.builder(
           scrollDirection: Axis.horizontal,
           itemBuilder: (context,index)=>Container(
             margin: const EdgeInsets.symmetric(horizontal: 5),
             width: 10,
             height: 10,
             decoration: BoxDecoration(
               shape: BoxShape.circle,
               color: ShopCubit.get(context).detailsIndex == index?myBlue :myBlack,
             ),
           ),
           itemCount: image.length,
         ),
       ),
     );
   }
   Widget myDescription({title, model, color}){
     TextStyle stylee= TextStyle(color: myBlue,fontSize: 18);
    return Directionality(
       textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Align(alignment:AlignmentDirectional.topStart,child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),),
          )),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child:  SizedBox(width: double.infinity
                ,child: Text("هودي رياضي مصمم للارتداء كل يوم في جميع الأوقات. يمكن تنسيقه ميمكن تنسيقه مع البنطلون الرياضي من تشكيلة اكتيف",style: TextStyle(fontSize: 18,height: 1.8,color:Colors.blueGrey),textDirection:TextDirection.rtl,)),
          ),
          Row(
            children: [
              Text("الموديل: "),
              Text(model,style: stylee,),
            ],
          ),
          Row(
            children: [
              Text("اللون: "),
              Text(color,style: stylee,),
            ],
          ),
        ],
      ),
    );
   }
   Widget anotherRow(quan,price){
    TextStyle stylee=const TextStyle(color: Colors.black,fontSize: 18);
    TextStyle style=const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Text("ألسعر",style:stylee,),
            Text("الكميه",style: stylee,),
          ],
        ),
       const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(price.toString(),style: style,),
            Text(quan.toString(),style: style,),
          ],
        ),
      ],
    );
   }
   Widget myFinalRow(size){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: myBlue,width: 2,style: BorderStyle.solid),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(child: Text(size,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: myBlue),),),
          ),
        ),
        BlueButton(title: "إضافة الي السلة", onpress: (){}, hight: 0.08, width: 0.50),
      ],
    );
   }
}
