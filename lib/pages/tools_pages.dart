import 'package:flutter/material.dart';
import 'package:adem/widget/app_bar.dart';

import '../widget/control_node.dart';
import '../widget/manual_mode.dart';
// import 'package:adem/widget/kandang_bar.dart';

class ToolPage extends StatefulWidget {
  const ToolPage({super.key});

  @override
  State<ToolPage> createState() {
    return _ToolPageState();
  }
}

class _ToolPageState extends State<ToolPage> {
  var selected = 0;
  bool manualMode = false; // Initial state of manual mode

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            ManualModeSwitch(
              manualMode: manualMode,
              onChanged: (value) {
                setState(() {
                  manualMode = value;
                });
              },
            ),
            ControlNode(
              manualMode: manualMode,
            ),
          ],
        ),
        // floatingActionButton: manualMode
        //     ? null // If manual mode is active, hide the floating action button
        //     : FloatingActionButton(
        //         onPressed: () {
        //           addNode();
        //         },
        //         backgroundColor: const Color(0xFF025464),
        //         child: const Icon(Icons.add),
        //       ),
      ),
    );
  }
}
