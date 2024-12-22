import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class Kelembaban {
  final double averageKelembaban;
  final Timestamp timestamp;

  Kelembaban(this.averageKelembaban, this.timestamp);

  Kelembaban.fromMap(Map<String, dynamic> map)
      : assert(map['average_kel'] != null),
        assert(map['timestamp'] != null),
        averageKelembaban = map['average_kel'].toDouble(),
        timestamp = map['timestamp'];

  @override
  String toString() => "Record<$averageKelembaban:$timestamp>";
}

class GrafikHumidity extends StatefulWidget {
  const GrafikHumidity({Key? key}) : super(key: key);

  @override
  _GrafikHumidity createState() => _GrafikHumidity();
}

class _GrafikHumidity extends State<GrafikHumidity> {
  late List<Kelembaban> mydata;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = Stream.periodic(Duration(minutes: 5)).listen((_) {
      // Lakukan permintaan Firestore untuk mendapatkan data terbaru
      // Ganti dengan kode stream Firestore yang sesuai
      FirebaseFirestore.instance
          .collection('average_kel')
          .orderBy('timestamp', descending: false)
          .limit(12)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          List<Kelembaban> kelembabanData = querySnapshot.docs.map((doc) {
            return Kelembaban.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();
          setState(() {
            mydata = kelembabanData;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

  double _getMaxKelembabanValue(List<Kelembaban> data) {
    double maxVal = 0.0;
    for (var kelembaban in data) {
      if (kelembaban.averageKelembaban > maxVal) {
        maxVal = kelembaban.averageKelembaban;
      }
    }
    return maxVal;
  }

  double _getMinKelembabanValue(List<Kelembaban> data) {
    double minVal = double.infinity;
    for (var kelembaban in data) {
      if (kelembaban.averageKelembaban < minVal) {
        minVal = kelembaban.averageKelembaban;
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
                      "Kelembaban",
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
                      .collection('average_kel')
                      .limit(12)
                      .orderBy('timestamp', descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      List<Kelembaban> kelembabanData = [];
                      for (QueryDocumentSnapshot document
                          in snapshot.data!.docs) {
                        Kelembaban kelembaban = Kelembaban.fromMap(
                            document.data() as Map<String, dynamic>);
                        kelembabanData.add(kelembaban);
                      }
                      mydata = kelembabanData;
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          height: 250,
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
                                    if (value ==
                                        _getMinKelembabanValue(mydata) - 2) {
                                      return '';
                                    } else {
                                      return value.toInt().toString();
                                    }
                                  },
                                ),
                                bottomTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 20,
                                  getTitles: (value) {
                                    int index = value.toInt() + 1;
                                    if (index > 0 && index <= 12) {
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
                              minX: 0,
                              maxX: 11,
                              minY: _getMinKelembabanValue(mydata) - 2,
                              maxY: _getMaxKelembabanValue(mydata) + 2,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: mydata.asMap().entries.map((entry) {
                                    return FlSpot(entry.key.toDouble(),
                                        entry.value.averageKelembaban);
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
