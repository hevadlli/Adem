import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GrafikAmoniak extends StatefulWidget {
  const GrafikAmoniak({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GrafikAmoniakState createState() => _GrafikAmoniakState();
}

class _GrafikAmoniakState extends State<GrafikAmoniak> {
  // ignore: non_constant_identifier_names
  List<FlSpot> AmoniakData = []; // Data untuk grafik kelembaban

  @override
  void initState() {
    super.initState();
    fetchHourlyAmoniakData();
  }

  void fetchHourlyAmoniakData() async {
    // Mengambil data dari Firestore dengan rentang waktu 12 jam terakhir
    final now = DateTime.now();
    final twelveHoursAgo = now.subtract(const Duration(hours: 12));

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('average_amoniak')
        .where('timestamp', isGreaterThanOrEqualTo: twelveHoursAgo)
        .orderBy('timestamp', descending: false)
        .get();

    // Mengelompokkan data per jam dan menghitung rata-rata kelembaban
    Map<int, List<double>> hourlyAmoniakMap = {};

    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      final timestamp = document['timestamp'] as Timestamp;
      final amoniak = document['average_amoniak'] as double;

      final hour = timestamp.toDate().hour;

      if (!hourlyAmoniakMap.containsKey(hour)) {
        hourlyAmoniakMap[hour] = [];
      }

      hourlyAmoniakMap[hour]!.add(amoniak);
    }

    // Menghitung rata-rata kelembaban untuk setiap jam
    for (final hour in hourlyAmoniakMap.keys) {
      // ignore: non_constant_identifier_names
      final Amoniakes = hourlyAmoniakMap[hour]!;
      final averageAmoniak = Amoniakes.reduce((a, b) => a + b) / Amoniakes.length;

      AmoniakData.add(FlSpot(hour.toDouble(), averageAmoniak));
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
              spots: AmoniakData,
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
