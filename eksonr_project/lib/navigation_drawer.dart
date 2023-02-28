import 'package:eksonr_project/drawer_item.dart';
import 'package:eksonr_project/globals.dart';
import 'package:eksonr_project/pages/search.dart';
import 'package:flutter/material.dart';

import 'package:eksonr_project/pages/dashboard.dart';
import 'package:eksonr_project/pages/settings.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 80, 24.0, 0),
          child: Column(
            children: [
              headerWidget(),
              const SizedBox(height: 40),
              const Divider(thickness: 1, height: 10, color: Colors.grey),
              const SizedBox(height: 40),
              DrawerItem(
                name: 'Dashboard',
                icon: Icons.dashboard,
                onPressed: () => onItemPressed(context, index: 0),
              ),
              const SizedBox(height: 30),
              DrawerItem(
                name: 'Search',
                icon: Icons.search,
                onPressed: () => onItemPressed(context, index: 1),
              ),
              const SizedBox(height: 30),
              const Divider(thickness: 1, height: 10, color: Colors.grey),
              const SizedBox(height: 30),
              DrawerItem(
                name: 'Settings',
                icon: Icons.settings,
                onPressed: () => onItemPressed(context, index: 2),
              ),
              const SizedBox(height: 30),
              DrawerItem(
                name: 'Log Out',
                icon: Icons.logout,
                onPressed: () => onItemPressed(context, index: 3),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);

    switch (index) {
      case 0:
        if (currentPageIndex != 0) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const DashboardPage()));
          currentPageIndex = 0;
        }
        break;
      case 1:
        if (currentPageIndex != 1) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SearchPage()));
          currentPageIndex = 1;
        }
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SettingsPage()));
        break;
    }
  }

  Widget headerWidget() {
    const url =
        'https://gratisography.com/wp-content/uploads/2023/01/gratisography-silly-spider-free-stock-photo-1170x780.jpg';
    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(url),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('User', style: TextStyle(fontSize: 14, color: Colors.white)),
            SizedBox(
              height: 10,
            ),
            Text(
              'user@email.com',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )
          ],
        )
      ],
    );
  }
}
