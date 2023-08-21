import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widget/humidity_chart.dart';

class ChartPage extends StatefulWidget {
  final Stream<QuerySnapshot<Map<String, dynamic>>> nodeStream;

  // Konstruktor dengan parameter yang dapat diisi atau tidak
  const ChartPage({Key? key, this.nodeStream = const Stream.empty()})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grafik Kelembaban'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: widget.nodeStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var data = snapshot.data!.docs;
          var dataPoints = data
              .asMap()
              .map((index, nodeData) => MapEntry(
                  index,
                  FlSpot(
                    index.toDouble(),
                    nodeData['kelembaban'] != null
                        ? double.parse(nodeData['kelembaban'].toString())
                        : 0.0,
                  )))
              .values
              .toList();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: HumidityChart(dataPoints: dataPoints),
          );
        },
      ),
    );
  }
}
