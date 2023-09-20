import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MonitorAmonia extends StatefulWidget {
  const MonitorAmonia({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MonitorAmonia createState() => _MonitorAmonia();
}

class _MonitorAmonia extends State<MonitorAmonia> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _nodeStream;
  double averageAmonia = 0.0;
  int totalNodes = 0;

  @override
  void initState() {
    super.initState();
    _nodeStream = FirebaseFirestore.instance.collection('Kandang1').snapshots();
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
                      double.parse('$averageAmonia'.toString())
                          .toStringAsFixed(1),
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
                          fontSize: 12,
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
                      return const CircularProgressIndicator();
                    }
                    var data = snapshot.data!.docs;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        // var nodeData = data[index].data();
                        var nodeReference = data[index].reference;
                        totalNodes = 0;
                        averageAmonia = 0.0;
                        return StreamBuilder<
                                QuerySnapshot<Map<String, dynamic>>>(
                            stream: nodeReference
                                .collection('Gas')
                                .orderBy('timestamp', descending: true)
                                .snapshots(),
                            builder: (context, subcollectionSnapshot) {
                              if (!subcollectionSnapshot.hasData) {
                                return const CircularProgressIndicator();
                              }
                              var subcollectionData =
                                  subcollectionSnapshot.data!.docs;
                              if (subcollectionData.isNotEmpty) {
                                averageAmonia +=
                                    subcollectionData[0]['amoniak'];
                                totalNodes++;
                              }

                              // Hitung rata-rata Amonia
                              averageAmonia = totalNodes > 0
                                  ? averageAmonia / totalNodes
                                  : 0.0;
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
                                          child: Row(
                                            children: [
                                              Text(
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
                                              const Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(5,0,0,10),
                                                child: Text(
                                                  'ppm',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
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
}
