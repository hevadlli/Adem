import 'package:flutter/material.dart';
// import 'package:adem/datas/dummy.dart';
// import 'package:adem/models/kandang_model.dart';
import 'package:adem/widget/app_bar.dart';
// import 'package:adem/widget/kandang_bar.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() {
    return _ChartPageState();
  }
}

class _ChartPageState extends State<ChartPage> {
  var selected = 0;

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(),
        body: Column(
          children: [
            // KandangBar(
            //   selected: selected,
            //   onSelect: (index) {
            //     setState(() {
            //       selected = index;
            //     });
            //   },
            //   onAddKandang: () {
            //     setState(() {
            //       KandangBar.addKandang(); // Call the addKandang function here
            //     });
            //   },
            // ),
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
                    "Grafik",
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
