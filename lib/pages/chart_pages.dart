import 'package:adem/widget/grafik_amonia.dart';
import 'package:adem/widget/grafik_kelembaban.dart';
import 'package:adem/widget/grafik_suhu.dart';
import 'package:flutter/material.dart';
import 'package:adem/widget/app_bar.dart';
// import 'package:adem/widget/kandang_bar.dart';


class ChartPage extends StatefulWidget {
  const ChartPage ({super.key});

  @override
  State<ChartPage > createState() {
    return _ChartPageState();
  }
}

class _ChartPageState extends State<ChartPage > {
  var selected = 0;

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFF6F6F6),
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
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
              //       KandangBar
              //           .addKandang(); // Call the addKandang function here
              //     });
              //   },
              // ),
              GrafikSuhu(),
              // GrafikHumidity(),
              // GrafikAmoniak()
            ],
          ),
        ),
      ),
    );
  }
  // Future<void> writeData(){

  // }
}
