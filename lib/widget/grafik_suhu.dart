import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GrafikSuhu extends StatefulWidget {
  const GrafikSuhu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GrafikSuhuState createState() => _GrafikSuhuState();
}

class _GrafikSuhuState extends State<GrafikSuhu> {
  // ignore: non_constant_identifier_names
  List<FlSpot> SuhuData = []; // Data untuk grafik kelembaban

  @override
  void initState() {
    super.initState();
    fetchHourlySuhuData();
  }

  void fetchHourlySuhuData() async {
    // Mengambil data dari Firestore dengan rentang waktu 12 jam terakhir
    final now = DateTime.now();
    final twelveHoursAgo = now.subtract(const Duration(hours: 12));

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('average_suhu')
        .where('timestamp', isGreaterThanOrEqualTo: twelveHoursAgo)
        .orderBy('timestamp', descending: false)
        .get();

    // Mengelompokkan data per jam dan menghitung rata-rata kelembaban
    Map<int, List<double>> hourlySuhuMap = {};

    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      final timestamp = document['timestamp'] as Timestamp;
      final suhu = document['average_suhu'] as double;

      final hour = timestamp.toDate().hour;

      if (!hourlySuhuMap.containsKey(hour)) {
        hourlySuhuMap[hour] = [];
      }

      hourlySuhuMap[hour]!.add(suhu);
    }

    // Menghitung rata-rata kelembaban untuk setiap jam
    for (final hour in hourlySuhuMap.keys) {
      // ignore: non_constant_identifier_names
      final Suhues = hourlySuhuMap[hour]!;
      final averageSuhu = Suhues.reduce((a, b) => a + b) / Suhues.length;

      SuhuData.add(FlSpot(hour.toDouble(), averageSuhu));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: SideTitles(showTitles: true),
            bottomTitles: SideTitles(showTitles: true),
          ),
          borderData: FlBorderData(show: true),
          minX: 0,
          maxX: 23, // 24 jam dalam sehari
          minY: 20,
          maxY: 40, // Sesuaikan dengan rentang kelembaban Anda
          lineBarsData: [
            LineChartBarData(
              spots: SuhuData,
              isCurved: true,
              colors: [Colors.blue],
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
