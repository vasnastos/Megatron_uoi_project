import 'package:eksonr_project/helpers/globals.dart';
import 'package:eksonr_project/helpers/sales_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DiagramContainer extends StatelessWidget {
  const DiagramContainer({super.key, required this.controller});

  final controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: double.infinity,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(50),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 3),
      ),
      child: PageView(
        controller: controller,
        children: <Widget>[
          SfCartesianChart(
            title: ChartTitle(
              text: "TOE",
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(
              enable: true,
              activationMode: ActivationMode.longPress,
            ),
            zoomPanBehavior: ZoomPanBehavior(enablePinching: true),
            series: <LineSeries<ToeData, int>>[
              LineSeries<ToeData, int>(
                dataSource: rightToeDatas,
                xValueMapper: (ToeData rtoe, _) => rtoe.index,
                yValueMapper: (ToeData rtoe, _) => rtoe.toe,
                name: "Right Toe",
                width: 5,
                animationDuration: 3000,
                markerSettings: const MarkerSettings(
                  isVisible: true,
                  height: 10,
                  width: 10,
                  borderWidth: 2.5,
                  shape: DataMarkerType.diamond,
                ),
                dataLabelSettings: const DataLabelSettings(
                  isVisible: false,
                ),
              ),
              LineSeries<ToeData, int>(
                dataSource: leftToeDatas,
                xValueMapper: (ToeData ltoe, _) => ltoe.index,
                yValueMapper: (ToeData ltoe, _) => ltoe.toe,
                name: "Left Toe",
                width: 5,
                animationDuration: 3000,
                markerSettings: const MarkerSettings(
                  isVisible: true,
                  height: 10,
                  width: 10,
                  borderWidth: 2.5,
                  shape: DataMarkerType.diamond,
                ),
                dataLabelSettings: const DataLabelSettings(
                  isVisible: false,
                ),
              )
            ],
          ),
          SfCartesianChart(
            title: ChartTitle(
              text: "HEEL",
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(
              enable: true,
              activationMode: ActivationMode.longPress,
            ),
            zoomPanBehavior: ZoomPanBehavior(enablePinching: true),
            series: <LineSeries<HeelData, int>>[
              LineSeries<HeelData, int>(
                dataSource: rightHeelDatas,
                xValueMapper: (HeelData heel, _) => heel.index,
                yValueMapper: (HeelData heel, _) => heel.heel,
                name: "Right Heel",
                width: 5,
                animationDuration: 3000,
                markerSettings: const MarkerSettings(
                  isVisible: true,
                  height: 10,
                  width: 10,
                  borderWidth: 2.5,
                  shape: DataMarkerType.diamond,
                ),
                dataLabelSettings: const DataLabelSettings(
                  isVisible: false,
                ),
              ),
              LineSeries<HeelData, int>(
                dataSource: leftHeelDatas,
                xValueMapper: (HeelData heel, _) => heel.index,
                yValueMapper: (HeelData heel, _) => heel.heel,
                name: "Left Heel",
                width: 5,
                animationDuration: 3000,
                markerSettings: const MarkerSettings(
                  isVisible: true,
                  height: 10,
                  width: 10,
                  borderWidth: 2.5,
                  shape: DataMarkerType.diamond,
                ),
                dataLabelSettings: const DataLabelSettings(
                  isVisible: false,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
