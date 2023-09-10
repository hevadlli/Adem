import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _notificationStream;

  @override
  void initState() {
    super.initState();
    _notificationStream =
        FirebaseFirestore.instance.collection('Notifikasi').orderBy('timestamp', descending: true).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikasi'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _notificationStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final notifications = snapshot.data!.docs;

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index].data();
              final message = notification['message'] as String;

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(169, 255, 255, 255),
                ),
                child: ListTile(
                  title: Text(
                    message,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF025464),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
