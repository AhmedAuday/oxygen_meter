import 'package:flutter/material.dart';

import '../Themes/themes.dart';

// this is a button widget easy to call
// ignore: must_be_immutable
class SwitchTileWidget extends StatefulWidget {
  SwitchTileWidget(
      {Key? key,
      required this.value,
      required this.title,
      this.subTitle,
      required this.onChanged,
      this.secondary})
      : super(key: key);
  bool value;
  Text title;
  Text? subTitle;
  Function(bool)
      onChanged; //(newValue) =>setState(() => switchListTileValue5 = newValue),
  Icon? secondary;
  @override
  State<SwitchTileWidget> createState() => _SwitchTileWidgetState();
}

class _SwitchTileWidgetState extends State<SwitchTileWidget> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      value: widget.value,
      onChanged: widget.onChanged,
      title: widget.title,
      subtitle: widget.subTitle,
      activeColor: MyThemeData.of(context).alternate,
      activeTrackColor: MyThemeData.of(context).alternate,
      dense: false,
      controlAffinity: ListTileControlAffinity.trailing,
      contentPadding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
      secondary: widget.secondary,
    );
  }
}
