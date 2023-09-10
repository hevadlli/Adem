import 'package:adem/widget/monitor_amonia.dart';
import 'package:flutter/material.dart';
import 'package:adem/widget/app_bar.dart';
// import 'package:adem/widget/kandang_bar.dart';
import '../widget/monitor_kelembaban.dart';
import '../widget/monitor_suhu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
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
              MonitorSuhu(),
              MonitorKelembaban(),
              MonitorAmonia()
            ],
          ),
        ),
      ),
    );
  }
  // Future<void> writeData(){

  // }
}
