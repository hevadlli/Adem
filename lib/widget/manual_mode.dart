import 'package:flutter/material.dart';

import '../models/manual_model.dart';

class ManualModeSwitch extends StatefulWidget {
  final bool manualMode;
  final ValueChanged<bool> onChanged;

  const ManualModeSwitch({
    Key? key,
    required this.manualMode,
    required this.onChanged,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ManualModeSwitchState createState() => _ManualModeSwitchState();
}

class _ManualModeSwitchState extends State<ManualModeSwitch> {
  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: PageStorageBucket(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              30,
              40,
              5,
              40,
            ),
            child: Text(
              "Manual Mode",
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF025464),
              ),
            ),
          ),
          Switch(
            value: ManualModeManager().manualMode,
            onChanged: (value) {
              ManualModeManager().setManualMode(value);
              widget.onChanged(value);
            },
            activeColor: const Color(0xFF025464),
          ),
        ],
      ),
    );
  }
}
