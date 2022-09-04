import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../model/earning_model.dart';
import '../../../../shared/compononet/componotents.dart';

class CustomBarChart extends StatelessWidget {
  List? customer;
  List? earn;
  List<EarningsTimeline>? listEarnings;
  CustomBarChart({Key? key, this.customer, this.earn, this.listEarnings})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      tooltipBehavior: TooltipBehavior(
          color: Colors.grey[400],
          enable: true,
          // Templating the tooltip
          builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
              int seriesIndex) {
            print(seriesIndex);
            return Container(
                height: MediaQuery.of(context).size.height * .09,
                child: Column(
                  children: [
                    Text(
                      'Customer No. : ${customer![seriesIndex].toString()}',
                      style: textStyle2,
                    ),
                    Text(
                      'Earn : ${earn![seriesIndex].toString()}',
                      style: textStyle2,
                    ),
                  ],
                ));
          }),
      // Initialize category axis
      primaryXAxis: CategoryAxis(),
      onDataLabelTapped: (onTapArgs) {
        //print(onTapArgs.pointIndex);
        print(onTapArgs.viewportPointIndex);
      },

      series: <ChartSeries<EarningsTimeline, String>>[
        ColumnSeries<EarningsTimeline, String>(
          onPointTap: (pointInteractionDetails) {
            print(pointInteractionDetails.pointIndex);
          },
          enableTooltip: true,
          dataSource: listEarnings!,
          xValueMapper: (EarningsTimeline timeline, _) => timeline.customer!,
          yValueMapper: (EarningsTimeline timeline, _) => timeline.earning,
        )
      ],
    );
  }
}
