import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MonitorSuhu extends StatefulWidget {
  const MonitorSuhu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MonitorSuhu createState() => _MonitorSuhu();
}

class _MonitorSuhu extends State<MonitorSuhu> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _nodeStream;
  double averageSuhu = 0.0;

  @override
  void initState() {
    super.initState();
    _nodeStream = FirebaseFirestore.instance.collection('Kandang1').snapshots();
  }

  void calculateAverage(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> nodeDataList) {
    double totalSuhu = 0.0;
    int nonNullCount = 0;

    for (var nodeData in nodeDataList) {
      var data = nodeData.data();
      if (data['suhu'] != null) {
        totalSuhu += double.parse(data['suhu'].toString());
        nonNullCount++;
      }
    }

    averageSuhu = nonNullCount > 0 ? totalSuhu / nonNullCount : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    //var suhu = kandangs.isNotEmpty ? kandangs[selected].averageValue.suhu : '';

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
                padding: const EdgeInsetsDirectional.fromSTEB(
                  15,
                  10,
                  0,
                  0,
                ),
                child: Row(
                  children: [
                    Text(
                      '$averageSuhu',
                      style: const TextStyle(
                        fontSize: 48,
                        color: Color(0xFF025464),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: Text(
                        "°C",
                        style: TextStyle(
                          fontSize: 20,
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
                    calculateAverage(data);

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        // var nodeData = data[index].data();
                        var nodeReference = data[index].reference;
                        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: nodeReference.collection('Temperature').snapshots(),
                          builder: (context, subcollectionSnapshot) {
                          if (!subcollectionSnapshot.hasData) {
                          return const CircularProgressIndicator();
                          }
                          var subcollectionData = subcollectionSnapshot.data!.docs;
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
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
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
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                          15,
                                          30,
                                          0,
                                          0,
                                        ),
                                        child: Text(
                                          subcollectionData.isNotEmpty
                                          ? subcollectionData[0]['suhu'].toString()
                                          : 'N/A',
                                          style: const TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
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
}
