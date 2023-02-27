import 'package:colorful_background/colorful_background.dart';
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
      body: ColorfulBackground(
        duration: const Duration(milliseconds: 2000),
        backgroundColors: const [
          Color(0xFF3e204f),
          Color(0xFF5a4565),
          Color(0xFFcec9d6),
          Color(0xFFe2dbe9),
          Color(0xFFbcaecc),
        ],
        // decoratorList is an optional attribute
        decoratorsList: [
          Positioned(
            top: MediaQuery.of(context).size.height / 2.5,
            left: MediaQuery.of(context).size.width / 2.5,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 90,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
        child: const SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Homepage(),
        ),
      ),
    );
  }
}
