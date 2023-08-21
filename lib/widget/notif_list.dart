import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationList extends StatefulWidget {
  final bool manualMode;

  const NotificationList({
    Key? key,
    required this.manualMode,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _nodeStream;

  @override
  void initState() {
    super.initState();
    _nodeStream = FirebaseFirestore.instance.collection('nodes').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _nodeStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final notifications = <Widget>[];

          for (var doc in snapshot.data!.docs) {
            final data = doc.data();
            if (data['relay'] == true && widget.manualMode) {
              notifications.add(
                Container(
                  margin: const EdgeInsetsDirectional.fromSTEB(
                    10,
                    20,
                    10,
                    20,
                  ),
                  width: double.infinity,
                  height: 160,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(169, 255, 255, 255),
                  ),
                  child: Text(
                    "Sprayer pada Node ${doc.id} diaktifkan Manual Suhu: ${data['suhu']}°C dan Kelembaban: ${data['kelembaban']}% terlalu tinggi.",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF025464),
                    ),
                  ),
                ),
              );
            } else if (data['relay'] == true) {
              notifications.add(
                Container(
                  margin: const EdgeInsetsDirectional.fromSTEB(
                    10,
                    20,
                    10,
                    20,
                  ),
                  width: double.infinity,
                  height: 160,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(169, 255, 255, 255),
                  ),
                  child: Text(
                    "Sprayer pada Node ${doc.id} diaktifkan Otomatis Suhu: ${data['suhu']}°C dan Kelembaban: ${data['kelembaban']}% terlalu tinggi.",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF025464),
                    ),
                  ),
                ),
              );
            }
          }

          return Column(
            children: notifications,
          );
        },
      ),
    );
  }
}
