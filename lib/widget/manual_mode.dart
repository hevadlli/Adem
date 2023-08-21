import 'package:flutter/material.dart';

class ManualModeSwitch extends StatefulWidget {
  final bool manualMode;
  final ValueChanged<bool> onChanged;

  const ManualModeSwitch({
    super.key,
    required this.manualMode,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ManualModeSwitchState createState() => _ManualModeSwitchState();
}

class _ManualModeSwitchState extends State<ManualModeSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
          value: widget.manualMode,
          onChanged: widget.onChanged,
          activeColor: const Color(0xFF025464),
        ),
      ],
    );
  }
}
