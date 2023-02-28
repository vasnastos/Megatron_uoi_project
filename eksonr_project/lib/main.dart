import 'package:eksonr_project/background.dart';
import 'package:flutter/material.dart';
import 'package:eksonr_project/navigation_drawer.dart';
import 'package:flutter/services.dart';

import 'datatable_from_csv.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    // SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);
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
      body: const Background(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DatatableFromCSV(),
        ),
      ),
    );
  }
}
