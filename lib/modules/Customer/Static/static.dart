import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/Customer/Static/widgets/custom_chart.dart';
import 'package:shopping/modules/Customer/Static/widgets/warning_container.dart';
import 'package:shopping/modules/Customer/cubit/cubit.dart';
import 'package:shopping/modules/Customer/cubit/state.dart';

import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

import '../../../model/earning_model.dart';

class StaticMain extends StatelessWidget {
  List<EarningsTimeline> listEarnings = [];
  List<EarningsTimeline> listEarning1 = [];
  List customerOfYear = [];
  List earnsOfYear = [];
  List customerOfMonth = [];
  List earnsOfMonth = [];

  TabController? controlle;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomerStates>(
      builder: (ctx, state) {
        var cubit = CustomerCubit.get(context).modelStatis;
        print(cubit?.data?.years!.keys);
        customerOfYear = [];
        customerOfMonth = [];
        earnsOfYear = [];
        earnsOfMonth = [];
        cubit?.data!.years!.forEach((key, value) {
          listEarnings.add(EarningsTimeline(
            customer: key,
            earning: value.earn,
          ));
          customerOfYear.add(value.customer);
          earnsOfYear.add(value.earn);
        });
        cubit?.data!.months!.forEach((key, value) {
          // listEarnings = [];
          listEarning1.add(EarningsTimeline(
            customer: key,
            earning: value.earn,
          ));
          customerOfMonth.add(value.customer);
          earnsOfMonth.add(value.earn);
        });
        return Scaffold(
            backgroundColor: myGrey,
            appBar: AppBar(
                backgroundColor: myGrey,
                title: Text(
                  mytranslate(context, "sat"),
                  style: textStyle1,
                )),
            body: cubit == null
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(29.0),
                        child: Column(
                          children: [
                            Text(
                              mytranslate(context, "tota"),
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
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  labelColor: myGrey,
                                  unselectedLabelColor: Colors.black,
                                  controller: controlle,
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        mytranslate(context, "yea"),
                                        style: textStyle,
                                      ),
                                    ),
                                    Tab(
                                        child: Text(
                                      mytranslate(context, "mon"),
                                      style: textStyle,
                                    )),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 0.2,
                                                color: myGrey!,
                                              ),
                                            ],
                                          ),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .55,
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              const Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10.0, bottom: 15),
                                                  child: InfoContainer()),
                                              Expanded(
                                                  child: CustomBarChart(
                                                customer: customerOfYear,
                                                earn: earnsOfYear,
                                                listEarnings: listEarnings,
                                              )),
                                            ],
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 0.2,
                                                color: myGrey!,
                                              ),
                                            ],
                                          ),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .55,
                                          padding: EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              const Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10.0, bottom: 15),
                                                  child: InfoContainer()),
                                              Expanded(
                                                  child: CustomBarChart(
                                                customer: customerOfMonth,
                                                earn: earnsOfMonth,
                                                listEarnings: listEarning1,
                                              )),
                                            ],
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
