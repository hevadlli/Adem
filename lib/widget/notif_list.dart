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
  List<String> notifications = []; // List to store notifications

  @override
  void initState() {
    super.initState();
    _nodeStream = FirebaseFirestore.instance.collection('nodes').snapshots();
  }

  void addNotification(String message) {
    if (notifications.length >= 20) {
      notifications.removeAt(0); // Remove the oldest notification
    }
    setState(() {
      notifications.add(message);
    });
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

          for (var doc in snapshot.data!.docs) {
            final data = doc.data();
            if (data['relay'] == true && widget.manualMode) {
              addNotification(
                "Sprayer pada ${doc.id} diaktifkan Manual Suhu: ${data['suhu']}°C dan Kelembaban: ${data['kelembaban']}% terlalu tinggi.",
              );
            } else if (data['relay'] == true) {
              addNotification(
                "Sprayer pada ${doc.id} diaktifkan Otomatis Suhu: ${data['suhu']}°C dan Kelembaban: ${data['kelembaban']}% terlalu tinggi.",
              );
            }
          }

          return SingleChildScrollView(
            child: Column(
              children: notifications.reversed
                  .map(
                    (notification) => Container(
                      margin: const EdgeInsetsDirectional.fromSTEB(
                        10,
                        20,
                        10,
                        20,
                      ),
                      width: double.infinity,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(169, 255, 255, 255),
                      ),
                      child: Text(
                        notification,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF025464),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
