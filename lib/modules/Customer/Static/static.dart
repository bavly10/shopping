import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/model/Stactic.dart';
import 'package:shopping/modules/Customer/cubit/cubit.dart';
import 'package:shopping/modules/Customer/cubit/state.dart';
import 'package:shopping/modules/test.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shopping/shared/compononet/componotents.dart';
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
        colorFn: (EarningsTimeline timeline, _) => timeline.barColor!,
      ),
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
            backgroundColor: myGrey,
            appBar: AppBar(
                backgroundColor: myGrey,
                title: Text(
                  "Statistics ",
                  style: textStyle1,
                )),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(29.0),
                  child: Column(
                    children: [
                      Text(
                        "My Total Money",
                        style: textStyle,
                      ),
                      Text(
                        cubit.data!.totalEarn.toString(),
                        style: textStyle1,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30, top: 8, bottom: 8),
                          child: TabBar(
                            indicator: BoxDecoration(
                                color: myBlue,
                                borderRadius: BorderRadius.circular(20.0)),
                            labelColor: myGrey,
                            unselectedLabelColor: Colors.black,
                            controller: controlle,
                            tabs: [
                              Tab(
                                child: Text(
                                  "Year",
                                  style: textStyle,
                                ),
                              ),
                              Tab(
                                  child: Text(
                                "Month",
                                style: textStyle,
                              )),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              color: myGrey,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Earn: ",
                                                    style: textStyle,
                                                  ),
                                                  Text(
                                                    cubit.data!.totalEarn
                                                        .toString(),
                                                    style: textStyle,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: charts.BarChart(
                                              timeline,
                                              domainAxis: const charts
                                                      .OrdinalAxisSpec(
                                                  renderSpec: charts
                                                      .SmallTickRendererSpec(

                                                          // Tick and Label styling here.
                                                          labelStyle: charts
                                                              .TextStyleSpec(
                                                                  fontSize:
                                                                      14, // size in Pts.
                                                                  color: charts
                                                                      .MaterialPalette
                                                                      .black),

                                                          // Change the line colors to match text color.
                                                          lineStyle: charts
                                                              .LineStyleSpec(
                                                                  thickness: 2,
                                                                  color: charts
                                                                      .MaterialPalette
                                                                      .black))),
                                              primaryMeasureAxis: charts
                                                  .NumericAxisSpec(
                                                      showAxisLine: true,
                                                      renderSpec: charts
                                                          .GridlineRendererSpec(
                                                              axisLineStyle: charts
                                                                  .LineStyleSpec(
                                                                      thickness:
                                                                          2,
                                                                      color: charts
                                                                          .MaterialPalette
                                                                          .black),

                                                              // Tick and Label styling here.
                                                              labelStyle: charts
                                                                  .TextStyleSpec(
                                                                      lineHeight:
                                                                          1.5,
                                                                      fontWeight:
                                                                          "bold",
                                                                      fontSize:
                                                                          16, // size in Pts.
                                                                      color: charts
                                                                          .MaterialPalette
                                                                          .black),

                                                              // Change the line colors to match text color.
                                                              lineStyle: charts.LineStyleSpec(
                                                                  thickness: 0,
                                                                  color: charts
                                                                      .MaterialPalette
                                                                      .black))),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              color: myGrey,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Earn: ",
                                                    style: textStyle,
                                                  ),
                                                  Text(
                                                    cubit.data!.totalEarn
                                                        .toString(),
                                                    style: textStyle,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: charts.BarChart(
                                              timeline1,
                                              domainAxis: const charts
                                                      .OrdinalAxisSpec(
                                                  renderSpec: charts
                                                      .SmallTickRendererSpec(

                                                          // Tick and Label styling here.
                                                          labelStyle: charts
                                                              .TextStyleSpec(
                                                                  fontSize:
                                                                      18, // size in Pts.
                                                                  color: charts
                                                                      .MaterialPalette
                                                                      .black),

                                                          // Change the line colors to match text color.
                                                          lineStyle: charts
                                                              .LineStyleSpec(
                                                                  thickness: 2,
                                                                  color: charts
                                                                      .MaterialPalette
                                                                      .black))),
                                              primaryMeasureAxis: charts
                                                  .NumericAxisSpec(
                                                      showAxisLine: true,
                                                      renderSpec: charts
                                                          .GridlineRendererSpec(
                                                              axisLineStyle: charts
                                                                  .LineStyleSpec(
                                                                      thickness:
                                                                          2,
                                                                      color: charts
                                                                          .MaterialPalette
                                                                          .black),

                                                              // Tick and Label styling here.
                                                              labelStyle: charts
                                                                  .TextStyleSpec(
                                                                      lineHeight:
                                                                          1.5,
                                                                      fontWeight:
                                                                          "bold",
                                                                      fontSize:
                                                                          18, // size in Pts.
                                                                      color: charts
                                                                          .MaterialPalette
                                                                          .black),

                                                              // Change the line colors to match text color.
                                                              lineStyle: charts.LineStyleSpec(
                                                                  thickness: 0,
                                                                  color: charts
                                                                      .MaterialPalette
                                                                      .black))),
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
