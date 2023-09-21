import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ControlNode extends StatefulWidget {
  final bool manualMode; // Pass manualMode as a parameter

  const ControlNode({Key? key, required this.manualMode}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ControlNodeState createState() => _ControlNodeState();
}

class _ControlNodeState extends State<ControlNode> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _nodeStream;
  bool resetNodes = false; // Flag to reset Kandang1

  @override
  void initState() {
    super.initState();
    _nodeStream = FirebaseFirestore.instance.collection('Kandang1').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
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

            // Reset nodes if resetNodes flag is set and manualMode is false
            if (!widget.manualMode) {
              for (var nodeDoc in data) {
                if (nodeDoc.data()['relay'] == true) {
                  // Update relay value to false in Firestore
                  FirebaseFirestore.instance
                      .collection('Kandang1')
                      .doc(nodeDoc.id)
                      .update({
                    'relay': false,
                  });
                }
              }
            }

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var nodeData = data[index].data();
                bool isNodeActive = nodeData['relay'] ?? false;

                return Container(
                  height: 100,
                  margin: const EdgeInsetsDirectional.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Node ${index + 1}',
                            style: const TextStyle(
                              fontSize: 24,
                              color: Color(0xFF025464),
                            ),
                          ),
                          Switch(
                            value: isNodeActive,
                            onChanged: widget.manualMode
                                ? (value) async {
                                    // Handle switch state change for node when manualMode is true
                                    // Set the new switch value to your node
                                    await FirebaseFirestore.instance
                                        .collection('Kandang1')
                                        .doc(data[index].id)
                                        .update({
                                      'relay': value,
                                    });

                                    if (value == true) {
                                      // Jika relay dinyalakan manual, kirim notifikasi ke koleksi "notification"
                                      await FirebaseFirestore.instance
                                          .collection('Notification')
                                          .add({
                                        'message':
                                            'Sprayer Node ${index + 1} dinyalakan manual.',
                                        'timestamp':
                                            FieldValue.serverTimestamp(),
                                      });
                                    }

                                    setState(() {
                                      // Update local UI state
                                    });
                                  }
                                : null,
                            activeColor: const Color(0xFF025464),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
