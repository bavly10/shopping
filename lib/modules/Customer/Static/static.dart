import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/model/Stactic.dart';
import 'package:shopping/modules/Customer/cubit/cubit.dart';
import 'package:shopping/modules/Customer/cubit/state.dart';
import 'package:shopping/modules/test.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shopping/shared/my_colors.dart';

class StaticMain extends StatelessWidget {
  List<EarningsTimeline> listEarnings = [];
  List<EarningsTimeline> listEarning1 = [];
  List mylist = [];
  TabController? controlle;
  @override
  Widget build(BuildContext context) {
    List<charts.Series<EarningsTimeline, String>> timeline = [
      charts.Series(
          id: "Subscribers",
          data: listEarnings,
          domainFn: (EarningsTimeline timeline, _) => timeline.customer!,
          measureFn: (EarningsTimeline timeline, _) => timeline.earning,
          colorFn: (EarningsTimeline timeline, _) => timeline.barColor!),
    ];
    List<charts.Series<EarningsTimeline, String>> timeline1 = [
      charts.Series(
          id: "Subscribers",
          data: listEarning1,
          domainFn: (EarningsTimeline timeline, _) => timeline.customer!,
          measureFn: (EarningsTimeline timeline, _) => timeline.earning,
          colorFn: (EarningsTimeline timeline, _) => timeline.barColor!),
    ];

    return BlocBuilder<CustomerCubit, CustomerStates>(
      builder: (ctx, state) {
        final cubit = CustomerCubit.get(context).modelStatis!;
        print(cubit.data?.years!.keys);

        cubit.data!.years!.forEach((key, value) {
          mylist.add(value.earn);
          // print(mylist);
          print("the erarn is${value.earn!}");
        });
        cubit.data!.years!.forEach((key, value) {
          // listEarnings = [];
          listEarnings.add(EarningsTimeline(
            customer: key,
            earning: value.earn,
            barColor: charts.ColorUtil.fromDartColor(myBlue),
          ));
        });
        cubit.data!.months!.forEach((key, value) {
          // listEarnings = [];
          listEarning1.add(EarningsTimeline(
            customer: key,
            earning: value.earn,
            barColor: charts.ColorUtil.fromDartColor(Colors.yellow[900]!),
          ));
        });
        return Scaffold(
            appBar:
                AppBar(title: Text("My Total Money:${cubit.data!.totalEarn} ")),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(29.0),
                  child: Column(
                    children: [
                      Text(
                        "My Total Money",
                      ),
                      Text(cubit.data!.totalEarn.toString())
                    ],
                  ),
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TabBar(
                            indicator: BoxDecoration(
                                color: myBlue,
                                borderRadius: BorderRadius.circular(20.0)),
                            labelColor: myGrey,
                            unselectedLabelColor: Colors.black,
                            controller: controlle,
                            tabs: const [
                              Tab(
                                child: Text(
                                  "Year",
                                ),
                              ),
                              Tab(
                                text: "Month",
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: TabBarView(
                              children: <Widget>[
                                Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: myBlue,
                                        style: BorderStyle.solid,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 0.2,
                                          color: myGrey!,
                                        ),
                                      ],
                                    ),
                                    height: 400,
                                    padding: EdgeInsets.all(20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "الارباح",
                                              ),
                                              Text(cubit.data!.totalEarn
                                                  .toString())
                                            ],
                                          ),
                                          Expanded(
                                            child: charts.BarChart(
                                              timeline,
                                              animate: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                                Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: myBlue,
                                        style: BorderStyle.solid,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 0.2,
                                          color: myGrey!,
                                        ),
                                      ],
                                    ),
                                    height: 400,
                                    padding: EdgeInsets.all(20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "الارباح",
                                              ),
                                              Text(cubit.data!.totalEarn
                                                  .toString())
                                            ],
                                          ),
                                          Expanded(
                                            child: charts.BarChart(
                                              timeline1,
                                              animate: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                              ],
                              controller: controlle,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}

class EarningsTimeline {
  final String? customer;
  final int? earning;
  charts.Color? barColor;

  EarningsTimeline(
      {required this.customer, required this.earning, this.barColor});
}
