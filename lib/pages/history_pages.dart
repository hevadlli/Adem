import 'package:flutter/material.dart';
// import 'package:adem/datas/database.dart';
// import 'package:adem/models/kandang_model.dart';
import 'package:adem/widget/app_bar.dart';
import 'package:adem/widget/kandang_bar.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() {
    return _HistoryPageState();
  }
}

class _HistoryPageState extends State<HistoryPage> {
  var selected = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            KandangBar(
              selected: selected,
              onSelect: (index) {
                setState(() {
                  selected = index;
                });
              },
              onAddKandang: () {
                setState(() {
                  KandangBar.addKandang(); // Call the addKandang function here
                });
              },
            ),
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
          ],
        ),
      ),
    );
  }
}
