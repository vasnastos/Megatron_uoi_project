import 'package:flutter/material.dart';

import '../datatable_from_csv.dart';

class DataTableContainer extends StatelessWidget {
  const DataTableContainer({super.key, required this.csvData});

  final csvData;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              onPageChanged: (value) {},
            ),
    );
  }
}
