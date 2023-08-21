import 'package:flutter/material.dart';
import 'package:adem/widget/app_bar.dart';
import '../models/manual_model.dart';
import '../widget/control_node.dart';
import '../widget/manual_mode.dart';

class ToolPage extends StatefulWidget {
  const ToolPage({Key? key}) : super(key: key);

  @override
  State<ToolPage> createState() {
    return _ToolPageState();
  }
}

class _ToolPageState extends State<ToolPage> {
  final ManualModeManager _manualModeManager = ManualModeManager();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            ManualModeSwitch(
              manualMode: _manualModeManager.manualMode,
              onChanged: (value) {
                setState(() {
                  _manualModeManager.setManualMode(value);
                });
              },
            ),
            ControlNode(
              manualMode: _manualModeManager.manualMode,
            ),
          ],
        ),
      ),
    );
  }
}
