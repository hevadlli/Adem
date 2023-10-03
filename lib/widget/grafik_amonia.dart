import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class Amoniak {
  final double averageAmoniak;
  final Timestamp timestamp;

  Amoniak(this.averageAmoniak, this.timestamp);

  Amoniak.fromMap(Map<String, dynamic> map)
      : assert(map['average_amoniak'] != null),
        assert(map['timestamp'] != null),
        averageAmoniak = map['average_amoniak'].toDouble(),
        timestamp = map['timestamp'];

  @override
  String toString() => "Record<$averageAmoniak:$timestamp>";
}

class GrafikAmoniak extends StatefulWidget {
  const GrafikAmoniak({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GrafikAmoniak createState() => _GrafikAmoniak();
}

class _GrafikAmoniak extends State<GrafikAmoniak> {
  late List<Amoniak> mydata;

  double _getMaxAmoniakValue(List<Amoniak> data) {
    double maxVal = 0.0;
    for (var amoniak in data) {
      if (amoniak.averageAmoniak > maxVal) {
        maxVal = amoniak.averageAmoniak;
      }
    }
    return maxVal;
  }

  double _getMinAmoniakValue(List<Amoniak> data) {
    double minVal = double.infinity;
    for (var amoniak in data) {
      if (amoniak.averageAmoniak < minVal) {
        minVal = amoniak.averageAmoniak;
      }
    }
    return minVal;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 10),
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
                      "Amoniak",
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
                      .collection('average_amoniak')
                      .orderBy('timestamp', descending: false)
                      .limit(12)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: CircularProgressIndicator());
                    } else {
                      List<Amoniak> amoniakData = [];
                      for (QueryDocumentSnapshot document
                          in snapshot.data!.docs) {
                        Amoniak amoniak = Amoniak.fromMap(
                            document.data() as Map<String, dynamic>);
                        amoniakData.add(amoniak);
                      }
                      mydata = amoniakData;
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
                                    if (value ==
                                        _getMinAmoniakValue(mydata) - 2) {
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
                                    int index = value.toInt();
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
                              minY: _getMinAmoniakValue(mydata) - 2,
                              maxY: _getMaxAmoniakValue(mydata) + 2,
                              lineBarsData: [
                                LineChartBarData(
                                  spots:
                                      mydata.asMap().entries.map((entry) {
                                    return FlSpot(entry.key.toDouble(),
                                        entry.value.averageAmoniak);
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
