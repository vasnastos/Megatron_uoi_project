import 'package:eksonr_project/background.dart';
import 'package:flutter/material.dart';
import 'package:storage_space/storage_space.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  StorageSpace? _storageSpace;

  @override
  void initState() {
    super.initState();
    initStorageSpace();
  }

  void initStorageSpace() async {
    StorageSpace storageSpace = await getStorageSpace(
      lowOnSpaceThreshold: 2 * 1024 * 1024 * 1024, // 2GB
      fractionDigits: 1,
    );
    setState(() {
      _storageSpace = storageSpace;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Background(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 400,
              width: double.infinity,
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.all(25),
              padding: const EdgeInsets.all(25),
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   border: Border.all(color: Colors.black, width: 3),
              // ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  const Text(
                    'Storage Space',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 75,
                    thickness: 1.25,
                    indent: 225,
                    endIndent: 225,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 200,
                              width: 200,
                              child: CircularProgressIndicator(
                                strokeWidth: 20,
                                value: _storageSpace?.usageValue,
                                backgroundColor: Colors.grey.shade200,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  (_storageSpace?.lowOnSpace ?? false)
                                      ? Colors.red
                                      : Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            if (_storageSpace == null) ...[
                              Text(
                                'Loading',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ],
                            if (_storageSpace != null) ...[
                              Column(
                                children: [
                                  Text(
                                    '${_storageSpace?.freeSize}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                  if (_storageSpace?.lowOnSpace != true) ...[
                                    Text(
                                      'Available',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ],
                                  if (_storageSpace?.lowOnSpace == true) ...[
                                    Text(
                                      'Low On Space',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.black,
              height: 800,
              thickness: 0.25,
              indent: 25,
              endIndent: 25,
            ),
          ],
        ),
      ),
    );
  }
}
