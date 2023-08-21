import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MonitorKelembaban extends StatefulWidget {
  const MonitorKelembaban({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MonitorKelembabanState createState() => _MonitorKelembabanState();
}

class _MonitorKelembabanState extends State<MonitorKelembaban> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _nodeStream;
  double averageKelembaban = 0.0;

  @override
  void initState() {
    super.initState();
    _nodeStream = FirebaseFirestore.instance.collection('nodes').snapshots();
  }

  void calculateAverage(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> nodeDataList) {
    double totalKelembaban = 0.0;
    int nonNullCount = 0;

    for (var nodeData in nodeDataList) {
      var data = nodeData.data();
      if (data['kelembaban'] != null) {
        totalKelembaban += double.parse(data['kelembaban'].toString());
        nonNullCount++;
      }
    }

    averageKelembaban = nonNullCount > 0 ? totalKelembaban / nonNullCount : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 30),
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
                padding: const EdgeInsetsDirectional.fromSTEB(
                  15,
                  10,
                  0,
                  0,
                ),
                child: Row(
                  children: [
                    Text(
                      '$averageKelembaban',
                      style: const TextStyle(
                        fontSize: 48,
                        color: Color(0xFF025464),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: Text(
                        "%",
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
                        var nodeData = data[index].data();
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
                                      nodeData['kelembaban'] != null
                                          ? nodeData['kelembaban'].toString()
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
