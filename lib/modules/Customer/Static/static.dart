import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/model/Stactic.dart';
import 'package:shopping/modules/Customer/cubit/cubit.dart';
import 'package:shopping/modules/Customer/cubit/state.dart';
import 'package:shopping/modules/test.dart';
import 'package:charts_flutter/flutter.dart' as charts;
class StaticMain extends StatelessWidget {
  List<EarningsTimeline> listEarnings =[];
  @override
  Widget build(BuildContext context) {
    List<charts.Series<EarningsTimeline, String>>  timeline = [
      charts.Series(
        id: "Subscribers",
        data: listEarnings,
        domainFn: (EarningsTimeline timeline, _) => timeline.customer!,
        measureFn: (EarningsTimeline timeline, _) => timeline.earning,
      )
    ];
    return BlocBuilder<CustomerCubit,CustomerStates>(
     builder: (ctx,state){
       final cubit=CustomerCubit.get(context).modelStatis!;
       print(cubit.data?.years!.keys);
       List mylist=[];
       cubit.data!.years!.forEach((key, value) {
         mylist.add(value.earn);
       });
       listEarnings .add(EarningsTimeline(customer: cubit.data?.years!.keys.toString(),earning:int.tryParse(mylist.toString()) ));
       return Scaffold(
         appBar: AppBar(title: Text("My Total Money:${cubit.data!.totalEarn} ")),
         body: Center(
             child: Container(
               height: 400,
               padding: EdgeInsets.all(20),
               child: Card(
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column(
                     children: <Widget>[
                       Text(
                         "Cristiano Ronaldo Earnings (\$M)",
                       ),
                       Expanded(
                         child: charts.BarChart(timeline, animate: true),
                       ),
                     ],
                   ),
                 ),
               ),
             )
         ),
       );
     },
    );
  }
}
class EarningsTimeline {
  final String? customer;
  final int? earning;

  EarningsTimeline({
    required this.customer,
    required this.earning,
  });
}