import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../Themes/themes.dart';
import '../widgets/switch_list.dart';
import 'DiscoveryPage.dart';
import 'SelectBondedDevicePage.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({Key? key}) : super(key: key);
  static String id = 'BluetoothPage';
  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String _address = "...";
  String _name = "...";

  Timer? _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;

  bool _autoAcceptPairingRequests = false;

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if ((await FlutterBluetoothSerial.instance.isEnabled) ?? false) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address!;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name!;
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        // Discoverable mode is disabled when Bluetooth gets disabled
        _discoverableTimeoutTimer = null;
        _discoverableTimeoutSecondsLeft = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyThemeData.of(context).secondaryColor,
        title: Text(
          'Bluetooth',
          style: MyThemeData.of(context).title1,
        ),
      ),
      backgroundColor: MyThemeData.of(context).primaryColor,
      body: ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        children: [
          SwitchTileWidget(
            value: _bluetoothState.isEnabled,
            title: Text(
              'ON/OFF',
              style: MyThemeData.of(context).title3,
            ),
            onChanged: (bool value) {
              // Do the request and update with the true value then
              future() async {
                // async lambda seems to not working
                if (value)
                  await FlutterBluetoothSerial.instance.requestEnable();
                else
                  await FlutterBluetoothSerial.instance.requestDisable();
              }

              future().then((_) {
                setState(() {});
              });
            },
            secondary: Icon(
              Icons.bluetooth,
              color: MyThemeData.of(context).iconColor,
            ),
          ),
          ListTile(
            title: ElevatedButton(
              child: const Text('Connect to paired device to chat'),
              onPressed: () async {
                final BluetoothDevice? selectedDevice =
                    await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return SelectBondedDevicePage(checkAvailability: false);
                    },
                  ),
                );

                if (selectedDevice != null) {
                  print('Connect -> selected ' + selectedDevice.address);
                } else {
                  print('Connect -> no device selected');
                }
              },
            ),
          ),
          Divider(),
          ListTile(
            title: ElevatedButton(
                child: const Text('Explore discovered devices'),
                onPressed: () async {
                  final BluetoothDevice? selectedDevice =
                      await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return DiscoveryPage();
                      },
                    ),
                  );

                  if (selectedDevice != null) {
                    print('Discovery -> selected ' + selectedDevice.address);
                  } else {
                    print('Discovery -> no device selected');
                  }
                }),
          ),
        ],
      ),
    );
  }
}
