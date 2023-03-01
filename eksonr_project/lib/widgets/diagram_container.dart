import 'package:eksonr_project/helpers/sales_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DiagramContainer extends StatelessWidget {
  const DiagramContainer(
      {super.key, required this.controller, required this.data});

  final controller;
  final data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: double.infinity,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(50),
      padding: const EdgeInsets.all(20),
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
            series: <LineSeries<HeelData, double>>[
              LineSeries<HeelData, double>(
                dataSource: [
                  HeelData(2, 1),
                  HeelData(2, 2),
                  HeelData(2, 3),
                  HeelData(2, 4),
                  HeelData(2, 5),
                  HeelData(2, 6),
                  HeelData(2, 7),
                  HeelData(2, 8),
                ],
                xValueMapper: (HeelData heel, _) => heel.heel,
                yValueMapper: (HeelData heel, _) => heel.index,
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
                  isVisible: true,
                ),
              ),
              LineSeries<HeelData, double>(
                dataSource: [
                  HeelData(1, 1),
                  HeelData(1, 2),
                  HeelData(1, 3),
                  HeelData(1, 4),
                  HeelData(1, 5),
                  HeelData(1, 6),
                  HeelData(1, 7),
                  HeelData(1, 8),
                ],
                xValueMapper: (HeelData heel, _) => heel.heel,
                yValueMapper: (HeelData heel, _) => heel.index,
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
                  isVisible: true,
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
            series: <LineSeries<HeelData, double>>[
              LineSeries<HeelData, double>(
                dataSource: [
                  HeelData(16, 1),
                  HeelData(19, 2),
                  HeelData(18, 3),
                  HeelData(15, 4),
                  HeelData(16, 5),
                  HeelData(16, 6),
                  HeelData(13, 7),
                  HeelData(18, 8),
                ],
                xValueMapper: (HeelData heel, _) => heel.heel,
                yValueMapper: (HeelData heel, _) => heel.index,
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
                  isVisible: true,
                ),
              ),
              LineSeries<HeelData, double>(
                dataSource: [
                  HeelData(9, 1),
                  HeelData(17, 2),
                  HeelData(9, 3),
                  HeelData(10, 4),
                  HeelData(14, 5),
                  HeelData(14, 6),
                  HeelData(14, 7),
                  HeelData(12, 8),
                ],
                xValueMapper: (HeelData heel, _) => heel.heel,
                yValueMapper: (HeelData heel, _) => heel.index,
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
                  isVisible: true,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
