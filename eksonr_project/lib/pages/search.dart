import 'package:eksonr_project/helpers/dataset.dart';
import 'package:flutter/material.dart';

import '../widgets/background.dart';
import '../navigation_drawer.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final pitch = TextEditingController();
  final roll = TextEditingController();
  final rtoe = TextEditingController();
  final rheel = TextEditingController();
  final ltoe = TextEditingController();
  final lheel = TextEditingController();
  final rhipx = TextEditingController();
  final rhipy = TextEditingController();
  final lhipx = TextEditingController();
  final lhipy = TextEditingController();
// y axis:
// X axis: pitch
  late Dataset ds = Dataset(
    pitch: pitch.text,
    roll: roll.text,
    rtoe: rtoe.text,
    rheel: rheel.text,
    ltoe: ltoe.text,
    lheel: lheel.text,
    rhipx: rhipx.text,
    rhipy: rhipy.text,
    lhipx: lhipx.text,
    lhipy: lhipy.text,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const CustomNavigationDrawer(),
      appBar: AppBar(
        title: const Text("EksoNR App"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      floatingActionButton: SizedBox(
        height: 150,
        width: 150,
        child: FittedBox(
          child: FloatingActionButton.extended(
            onPressed: () {
              // Set dataset class values
              ds = Dataset(
                pitch: pitch.text,
                roll: roll.text,
                rtoe: rtoe.text,
                rheel: rheel.text,
                ltoe: ltoe.text,
                lheel: lheel.text,
                rhipx: rhipx.text,
                rhipy: rhipy.text,
                lhipx: lhipx.text,
                lhipy: lhipy.text,
              );
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    // Retrieve the text the that user has entered by using the
                    // TextEditingController.
                    content: Container(
                      alignment: Alignment.topLeft,
                      height: 250,
                      child: Column(
                        children: [
                          const Text(
                            "DATASET\n",
                          ),
                          Text(
                            ds.printData(),
                            //"Pitch: ${pitch.text}\nRoll: ${roll.text}\nRToe: ${rtoe.text}\nRheel: ${rheel.text}\nLToe: ${ltoe.text}\nLHeel: ${lheel.text}\nRHipX: ${rhipx.text}\nRHipY: ${rhipy.text}\nLHipX: ${lhipx.text}\nLHipY: ${lhipy.text}"
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.search),
            label: const Text("Search"),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Background(
        child: Stack(
          children: <Widget>[
            Container(
              height: 1000,
              width: double.infinity,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(50),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(175, 255, 255, 255),
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: Column(
                children: [
                  const Text(
                    'Search',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 890,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextField(
                            controller: pitch,
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: true,
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              label: Text('Pitch'),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: roll,
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: true,
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              label: Text('Roll'),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: rtoe,
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: true,
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              label: Text('RToe'),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: rheel,
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: true,
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              label: Text('RHeel'),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: ltoe,
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: true,
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              label: Text('LToe'),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: lheel,
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: true,
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              label: Text('LHeel'),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: rhipx,
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: true,
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              label: Text('RHipX'),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: rhipy,
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: true,
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              label: Text('RHipY'),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: lhipx,
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: true,
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              label: Text('LHipX'),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: lhipy,
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: true,
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              label: Text('LHipY'),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
