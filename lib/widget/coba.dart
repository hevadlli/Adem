import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class GrafikSuhuScreen extends StatefulWidget {
  const GrafikSuhuScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GrafikSuhuScreenState createState() => _GrafikSuhuScreenState();
}

class _GrafikSuhuScreenState extends State<GrafikSuhuScreen> {
  List<DocumentSnapshot> dataSuhu = [];

  @override
  void initState() {
    super.initState();
    loadDataSuhu();
  }

  // Fungsi untuk mengambil data suhu dari Firestore
  Future<void> loadDataSuhu() async {
    // Ganti 'suhu' dengan nama koleksi di Firestore Anda
    List<QuerySnapshot> snapshots = [];

    for (int index = 1; index <= 12; index++) { // Ambil data dari 12 jam yang berbeda
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Kandang1')
          .doc('Node1')
          .collection('Temperature')
          .where('jam', isEqualTo: index.toString()) // Filter berdasarkan jam yang berbeda
          .orderBy('timestamp', descending: true)
          .limit(1) // Ambil 1 data terbaru untuk setiap jam
          .get();
      snapshots.add(snapshot);
    }

    setState(() {
      dataSuhu = snapshots.expand((snapshot) => snapshot.docs).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: const Color(0xff37434d),
              width: 1,
            ),
          ),
          minX: 0,
          maxX: 11,
          minY: 0,
          maxY: 100, // Sesuaikan dengan rentang nilai suhu Anda
          lineBarsData: [
            LineChartBarData(
              spots: dataSuhu.asMap().entries.map((entry) {
                final int index = entry.key;
                final DocumentSnapshot data = entry.value;
                final double nilaiSuhu = data['nilaiSuhu'].toDouble();
                return FlSpot(index.toDouble(), nilaiSuhu);
              }).toList(),
              isCurved: true,
              colors: [Colors.blue],
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
