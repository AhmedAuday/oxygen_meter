import 'package:flutter/material.dart';

import '../Themes/themes.dart';

class ManualPageWidget extends StatefulWidget {
  const ManualPageWidget({Key? key}) : super(key: key);

  @override
  _ManualPageWidgetState createState() => _ManualPageWidgetState();
}

class _ManualPageWidgetState extends State<ManualPageWidget> {
  bool? switchListTileValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyThemeData.of(context).secondaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Manual',
          style: MyThemeData.of(context).title1,
        ),
      ),
      backgroundColor: MyThemeData.of(context).primaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                child: Text(
                  'Oxygen Level : 100%',
                  style: MyThemeData.of(context).bodyText1,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                child: Text(
                  'Heart Rate : 109',
                  style: MyThemeData.of(context).bodyText1,
                ),
              ),
              Text(
                'Servo degree : 190~',
                style: MyThemeData.of(context).bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
