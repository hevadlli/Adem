import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class MonitorAmonia extends StatefulWidget {
  const MonitorAmonia({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MonitorAmoniaState createState() => _MonitorAmoniaState();
}

class _MonitorAmoniaState extends State<MonitorAmonia> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _nodeStream;
  double _averageAmoniak = 0.0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _nodeStream = FirebaseFirestore.instance.collection('Kandang1').snapshots();

    // Membuat timer untuk pembaruan setiap 1 menit
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _updateAverageAmoniak();
    });

    // Memanggil _updateAverageAmoniak() untuk menginisialisasi rata-rata awal
    _updateAverageAmoniak();
  }

  // Metode untuk menghitung ulang rata-rata amonia
  void _updateAverageAmoniak() async {
    double totalAmoniak = 0.0;
    int nodeCount = 0;

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('Kandang1').get();

    for (var doc in snapshot.docs) {
      var subcollectionRef = doc.reference.collection('Gas');
      var subcollectionSnapshot = await subcollectionRef
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (subcollectionSnapshot.docs.isNotEmpty) {
        var amoniak = subcollectionSnapshot.docs.first['amoniak'];
        totalAmoniak += amoniak;
        nodeCount++;
      }
    }

    double averageAmoniak = nodeCount > 0 ? totalAmoniak / nodeCount : 0.0;
    DateTime now = DateTime.now();
    int currentHour = now.hour;

// Konversi ke format 24 jam
    // int formattedHour12 = currentHour == 12 ? 12 : (currentHour + 12) % 24;
    if (currentHour > 12) {
      String formattedHour = (currentHour - 12).toString().padLeft(2, '0');
      // Upload data rata-rata ke Firestore setiap 1 menit
      FirebaseFirestore.instance
          .collection('average_amoniak') // Ganti dengan koleksi yang sesuai
          .doc(formattedHour) // Ganti dengan dokumen yang sesuai
          .set({
        'average_amoniak': averageAmoniak,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } else {
      String formattedHour = currentHour.toString().padLeft(2, '0');
      // Upload data rata-rata ke Firestore setiap 1 menit
      FirebaseFirestore.instance
          .collection('average_amoniak') // Ganti dengan koleksi yang sesuai
          .doc(formattedHour) // Ganti dengan dokumen yang sesuai
          .set({
        'average_amoniak': averageAmoniak,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
    setState(() {
      _averageAmoniak = averageAmoniak;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 30, 15, 15),
      child: Material(
        elevation: 4,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.transparent,
        child: Container(
          height: 305,
          width: double.infinity,
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
                  15,
                  20,
                  0,
                  0,
                ),
                child: Row(
                  children: [
                    Text(
                      "Amonia",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF025464),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  15,
                  10,
                  0,
                  0,
                ),
                child: Row(
                  children: [
                    Text(
                      _averageAmoniak.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 48,
                        color: Color(0xFF025464),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: Text(
                        "ppm",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF025464),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsetsDirectional.fromSTEB(
                  10,
                  20,
                  10,
                  10,
                ),
                width: double.infinity,
                height: 145,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _nodeStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(color: Colors.white),
                      );
                    }
                    var data = snapshot.data!.docs;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var nodeReference = data[index].reference;
                        return StreamBuilder<
                            QuerySnapshot<Map<String, dynamic>>>(
                          stream: nodeReference
                              .collection('Gas')
                              .orderBy('timestamp', descending: true)
                              .snapshots(),
                          builder: (context, subcollectionSnapshot) {
                            if (!subcollectionSnapshot.hasData) {
                              return Container(
                                width: double.infinity,
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                              );
                            }
                            var subcollectionData =
                                subcollectionSnapshot.data!.docs;
                            return Container(
                              margin: const EdgeInsetsDirectional.fromSTEB(
                                10,
                                0,
                                0,
                                0,
                              ),
                              height: 145,
                              width: 110,
                              decoration: BoxDecoration(
                                color: const Color(0xFF025464),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(
                                          15,
                                          10,
                                          0,
                                          0,
                                        ),
                                        child: Text(
                                          'Node ${index + 1}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(
                                          15,
                                          30,
                                          0,
                                          0,
                                        ),
                                        child: Text(
                                          subcollectionData.isNotEmpty
                                              ? double.parse(
                                                      subcollectionData[0]
                                                              ['amoniak']
                                                          .toString())
                                                  .toStringAsFixed(1)
                                              : 'N/A',
                                          style: const TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 23, 5, 0),
                                        child: Text(
                                          'ppm',
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      itemCount: data.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Batalkan timer saat widget dihapus
    _timer.cancel();
    super.dispose();
  }
}
