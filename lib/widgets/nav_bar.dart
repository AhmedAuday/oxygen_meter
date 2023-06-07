import 'package:flutter/material.dart';

import '../Themes/themes.dart';
import '../screens/autonatic.dart';
import '../screens/manual.dart';
import '../screens/bluetooth.dart';

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage}) : super(key: key);

  final String? initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  String _currentPage = 'HomePage';

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? _currentPage;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'HomePage': HomePageWidget(),
      'ManualPage': ManualPageWidget(),
      'BluetoothPage': BluetoothPage(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPage);
    return Scaffold(
      body: tabs[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => _currentPage = tabs.keys.toList()[i]),
        backgroundColor: MyThemeData.of(context).secondaryColor,
        selectedItemColor: MyThemeData.of(context).alternate,
        unselectedItemColor: Color(0x8AF7F7F7),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 24,
            ),
            label: 'Automatic',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fiber_manual_record_outlined,
              size: 30,
            ),
            label: 'Manual',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.settings,
              size: 24,
            ),
            label: 'Settings',
            tooltip: '',
          )
        ],
      ),
    );
  }
}
