import 'package:flutter/material.dart';
import 'package:eksonr_project/navigation_drawer.dart';

import 'datatable_from_csv.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(72, 24, 101, 0.5),
      drawer: const CustomNavigationDrawer(),
      appBar: AppBar(
        title: const Text("EksoNR App"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Homepage(),
      ),
    );
  }
}
