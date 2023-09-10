import 'package:flutter/material.dart';
import 'package:adem/widget/app_bar.dart';

import '../widget/notif_list.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() {
    return _HistoryPageState();
  }
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(),
        body: Column(
          children: [
            Row(
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
            NotificationList(
              ),
          ],
        ),
      ),
    );
  }
}
