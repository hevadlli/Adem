import 'package:flutter/material.dart';
import 'package:adem/widget/app_bar.dart';

import '../widget/notif_list.dart';

class HistoryPage extends StatefulWidget {
  final bool manualMode; // Tambahkan properti manualMode
  const HistoryPage({Key? key, required this.manualMode}) : super(key: key);

  @override
  State<HistoryPage> createState() {
    return _HistoryPageState();
  }
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    30,
                    40,
                    30,
                    40,
                  ),
                  child: Text(
                    "History",
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF025464),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: NotificationList(
                manualMode: widget.manualMode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
