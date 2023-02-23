import 'package:flutter/material.dart';
import 'package:csv/csv.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 600,
          width: double.infinity,
          //color: Colors.purple,
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
          child: const Text(
            'Diagram',
            style: TextStyle(
              fontSize: 50,
            ),
          ),
        ),
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
