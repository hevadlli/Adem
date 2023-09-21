import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GrafikHumidity extends StatefulWidget {
  const GrafikHumidity({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GrafikHumidityState createState() => _GrafikHumidityState();
}

class _GrafikHumidityState extends State<GrafikHumidity> {
  // ignore: non_constant_identifier_names
  List<FlSpot> HumidityData = []; // Data untuk grafik kelembaban

  @override
  void initState() {
    super.initState();
    fetchHourlyHumidityData();
  }

  void fetchHourlyHumidityData() async {
    // Mengambil data dari Firestore dengan rentang waktu 12 jam terakhir
    final now = DateTime.now();
    final twelveHoursAgo = now.subtract(const Duration(hours: 12));

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('average_kel')
        .where('timestamp', isGreaterThanOrEqualTo: twelveHoursAgo)
        .orderBy('timestamp', descending: false)
        .get();

    // Mengelompokkan data per jam dan menghitung rata-rata kelembaban
    Map<int, List<double>> hourlyHumidityMap = {};

    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      final timestamp = document['timestamp'] as Timestamp;
      final humidity = document['average_kel'] as double;

      final hour = timestamp.toDate().hour;

      if (!hourlyHumidityMap.containsKey(hour)) {
        hourlyHumidityMap[hour] = [];
      }

      hourlyHumidityMap[hour]!.add(humidity);
    }

    // Menghitung rata-rata kelembaban untuk setiap jam
    for (final hour in hourlyHumidityMap.keys) {
      // ignore: non_constant_identifier_names
      final Humidities = hourlyHumidityMap[hour]!;
      final averageHumidity = Humidities.reduce((a, b) => a + b) / Humidities.length;

      HumidityData.add(FlSpot(hour.toDouble(), averageHumidity));
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
          minY: 50,
          maxY: 70, // Sesuaikan dengan rentang kelembaban Anda
          lineBarsData: [
            LineChartBarData(
              spots: HumidityData,
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
