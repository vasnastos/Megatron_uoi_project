import 'package:flutter/material.dart';

import '../background.dart';
import '../datatable_from_csv.dart';
import '../navigation_drawer.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomNavigationDrawer(),
      appBar: AppBar(
        title: const Text("EksoNR App"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: const Background(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DatatableFromCSV(),
        ),
      ),
    );
  }
}
