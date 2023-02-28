import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class DatatableFromCSV extends StatefulWidget {
  const DatatableFromCSV({super.key});

  @override
  State<DatatableFromCSV> createState() => _DatatableFromCSV();
}

class _DatatableFromCSV extends State<DatatableFromCSV> {
  List<List<dynamic>>? csvData;

  Future<List<List<dynamic>>> processCsv() async {
    var result = await DefaultAssetBundle.of(context).loadString(
      "assets/data.csv",
    );
    return const CsvToListConverter().convert(result, eol: "\n");
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  Future refresh() async {
    csvData = await processCsv();
    setState(() {});
  }

  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];

  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 600,
          width: double.infinity,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(50),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 3),
          ),
          child: csvData == null
              ? const CircularProgressIndicator()
              : PaginatedDataTable(
                  source: MyData(csvData!),
                  header: const Center(child: Text('Dashboard')),
                  columns: const [
                    DataColumn(label: Text('Pitch')),
                    DataColumn(label: Text('Roll')),
                    DataColumn(label: Text('RToe')),
                    DataColumn(label: Text('RHeel')),
                    DataColumn(label: Text('LToe')),
                    DataColumn(label: Text('LHeel')),
                    DataColumn(label: Text('RHipX')),
                    DataColumn(label: Text('RHipY')),
                    DataColumn(label: Text('LHipX')),
                    DataColumn(label: Text('LHipY')),
                  ],
                  columnSpacing: 75,
                  horizontalMargin: 10,
                  rowsPerPage: 8,
                  showCheckboxColumn: false,
                ),
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          height: 600,
          width: double.infinity,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(50),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 3),
          ),
          child: PageView(
            controller: _controller,
            children: <Widget>[
              Column(
                children: [
                  //Initialize the chart widget
                  SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      // Chart title
                      title: ChartTitle(text: 'Half yearly sales analysis'),
                      // Enable legend
                      legend: Legend(isVisible: true),
                      // Enable tooltip
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<_SalesData, String>>[
                        LineSeries<_SalesData, String>(
                            dataSource: data,
                            xValueMapper: (_SalesData sales, _) => sales.year,
                            yValueMapper: (_SalesData sales, _) => sales.sales,
                            name: 'Sales',
                            // Enable data label
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true))
                      ]),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      //Initialize the spark charts widget
                      child: SfSparkLineChart.custom(
                        //Enable the trackball
                        trackball: const SparkChartTrackball(
                            activationMode: SparkChartActivationMode.tap),
                        //Enable marker
                        marker: const SparkChartMarker(
                            displayMode: SparkChartMarkerDisplayMode.all),
                        //Enable data label
                        labelDisplayMode: SparkChartLabelDisplayMode.all,
                        xValueMapper: (int index) => data[index].year,
                        yValueMapper: (int index) => data[index].sales,
                        dataCount: 5,
                      ),
                    ),
                  )
                ],
              ),
              SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Chart title
                  title: ChartTitle(text: 'Half yearly sales analysis'),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<_SalesData, String>>[
                    LineSeries<_SalesData, String>(
                        dataSource: data,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: 'Sales',
                        // Enable data label
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true))
                  ]),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  //Initialize the spark charts widget
                  child: SfSparkLineChart.custom(
                    //Enable the trackball
                    trackball: const SparkChartTrackball(
                        activationMode: SparkChartActivationMode.tap),
                    //Enable marker
                    marker: const SparkChartMarker(
                        displayMode: SparkChartMarkerDisplayMode.all),
                    //Enable data label
                    labelDisplayMode: SparkChartLabelDisplayMode.all,
                    xValueMapper: (int index) => data[index].year,
                    yValueMapper: (int index) => data[index].sales,
                    dataCount: 5,
                  ),
                ),
              )
            ],
          ),
        ),
        SmoothPageIndicator(
          controller: _controller, // PageController
          count: 3,
          effect: const WormEffect(),
        ),
        const SizedBox(
          height: 100,
        )
      ],
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

// The "soruce" of the table
class MyData extends DataTableSource {
  late final List<List<dynamic>> _data;

  MyData(List<List<dynamic>> data) {
    _data = data.sublist(1);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(
        Text(_data[index][0].toString()),
      ),
      DataCell(
        Text(_data[index][1].toString()),
      ),
      DataCell(
        Text(_data[index][2].toString()),
      ),
      DataCell(
        Text(_data[index][3].toString()),
      ),
      DataCell(
        Text(_data[index][4].toString()),
      ),
      DataCell(
        Text(_data[index][5].toString()),
      ),
      DataCell(
        Text(_data[index][6].toString()),
      ),
      DataCell(
        Text(_data[index][7].toString()),
      ),
      DataCell(
        Text(_data[index][8].toString()),
      ),
      DataCell(
        Text(_data[index][9].toString()),
      ),
    ]);
  }
}
