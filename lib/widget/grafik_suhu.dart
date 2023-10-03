import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: GrafikSuhu(),
//   ));
// }

class Suhu {
  final double averageSuhu;
  final Timestamp timestamp;

  Suhu(this.averageSuhu, this.timestamp);

  Suhu.fromMap(Map<String, dynamic> map)
      : assert(map['average_suhu'] != null),
        assert(map['timestamp'] != null),
        averageSuhu = map['average_suhu'].toDouble(),
        timestamp = map['timestamp'];

  @override
  String toString() => "Record<$averageSuhu:$timestamp>";
}

class GrafikSuhu extends StatefulWidget {
  const GrafikSuhu({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GrafikSuhu createState() => _GrafikSuhu();
}

class _GrafikSuhu extends State<GrafikSuhu> {
  late List<Suhu> mydata;

  double _getMaxSuhuValue(List<Suhu> data) {
    double maxVal = 0.0;
    for (var suhu in data) {
      if (suhu.averageSuhu > maxVal) {
        maxVal = suhu.averageSuhu;
      }
    }
    return maxVal;
  }

  double _getMinSuhuValue(List<Suhu> data) {
    double minVal = double.infinity;
    for (var suhu in data) {
      if (suhu.averageSuhu < minVal) {
        minVal = suhu.averageSuhu;
      }
    }
    return minVal;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 20, 15, 10),
      child: Material(
        elevation: 4,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.transparent,
        child: Container(
          height: 360,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                  20,
                  20,
                  0,
                  0,
                ),
                child: Row(
                  children: [
                    Text(
                      "Suhu",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF025464),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('average_suhu')
                      .limit(12)
                      .orderBy('timestamp', descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      List<Suhu> suhuData = [];
                      for (QueryDocumentSnapshot document
                          in snapshot.data!.docs) {
                        Suhu suhu = Suhu.fromMap(
                            document.data() as Map<String, dynamic>);
                        suhuData.add(suhu);
                      }
                      mydata = suhuData;
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          height: 250, // Sesuaikan tinggi sesuai kebutuhan
                          child: LineChart(
                            LineChartData(
                              gridData: FlGridData(show: true),
                              titlesData: FlTitlesData(
                                rightTitles: SideTitles(showTitles: false),
                                topTitles: SideTitles(showTitles: false),
                                leftTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 20,
                                  getTitles: (value) {
                                    // Tampilkan angka bulat di sumbu Y, dimulai dari 1
                                    if (value == _getMinSuhuValue(mydata) - 1) {
                                      return ''; // Jika nilai adalah 0, maka jangan tampilkan label
                                    } else {
                                      return value.toInt().toString();
                                    }
                                  },
                                ),
                                bottomTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 20,
                                  getTitles: (value) {
                                    // Tampilkan jam di sumbu X
                                    int index = value.toInt() + 1;
                                    if (index >= 0 && index <= 12) {
                                      if ((index) % 2 == 0) {
                                        DateTime currentTime = DateTime.now();
                                        DateTime timestamp =
                                            currentTime.subtract(
                                                Duration(hours: 12 - index));
                                        String hour = timestamp.hour
                                            .toString()
                                            .padLeft(2, '0');
                                        return hour;
                                      }
                                    }
                                    return '';
                                  },
                                ),
                              ),
                              borderData: FlBorderData(show: false),
                              minX: -1,
                              maxX: 11,
                              minY: _getMinSuhuValue(mydata) - 1,
                              maxY: _getMaxSuhuValue(mydata) + 1,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: mydata.asMap().entries.map((entry) {
                                    return FlSpot(entry.key.toDouble(),
                                        entry.value.averageSuhu);
                                  }).toList(),
                                  isCurved: true,
                                  colors: [const Color(0xFF025464)],
                                  dotData: FlDotData(show: true),
                                  belowBarData: BarAreaData(show: false),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
