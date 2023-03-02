import 'package:eksonr_project/helpers/globals.dart';
import 'package:eksonr_project/widgets/datatable_container.dart';
import 'package:eksonr_project/widgets/diagram_container.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:eksonr_project/helpers/sales_data.dart';

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
    return const CsvToListConverter().convert(
      result,
      eol: "\n",
      shouldParseNumbers: false,
    );
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  Future refresh() async {
    csvData = await processCsv();
    for (var i = 1; i < csvData!.length; i++) {
      ToeData rightToeData = ToeData(i, double.parse(csvData![i][3]));
      rightToeDatas.add(rightToeData);

      ToeData leftToeData = ToeData(i, double.parse(csvData![i][5]));
      leftToeDatas.add(leftToeData);

      HeelData rightHeelData = HeelData(i, double.parse(csvData![i][3]));
      rightHeelDatas.add(rightHeelData);

      HeelData leftHeelData = HeelData(i, double.parse(csvData![i][5]));
      leftHeelDatas.add(leftHeelData);
    }
    setState(() {});
  }

  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DataTableContainer(
          csvData: csvData,
        ),
        const SizedBox(
          height: 25,
        ),
        DiagramContainer(
          controller: _controller,
        ),
        SmoothPageIndicator(
          controller: _controller, // PageController
          count: 2,
          effect: const WormEffect(),
        ),
        const SizedBox(
          height: 100,
        )
      ],
    );
  }
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
