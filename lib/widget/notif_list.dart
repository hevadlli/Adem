import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationList extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const NotificationList({Key? key}); // Ganti super.key menjadi Key? key

  @override
  // ignore: library_private_types_in_public_api
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _notificationStream;

  @override
  void initState() {
    super.initState();
    _notificationStream = FirebaseFirestore.instance
        .collection('Notification')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _notificationStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            var notifications = snapshot.data!.docs;

            return ListView.builder(
              itemCount: notifications.length > 20
                  ? 20
                  : notifications.length, // Batasi hanya 20 item
              itemBuilder: (context, index) {
                if (index < 20) {
                  // Hanya tampilkan item dari 0 hingga 19
                  var notification = notifications[index].data();
                  var message = notification['message'] as String;
                  Timestamp timestamp = notification['timestamp'];
                  DateTime dateTime = timestamp.toDate();
                  String formattedDate =
                      DateFormat('dd/MM/yyyy').format(dateTime);
                  String formattedTime = DateFormat('HH:mm').format(dateTime);

                  return Container(
                    height: 80,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(169, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Column(
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsetsDirectional.only(top: 5),
                                child: Text(
                                  "Notifikasi  ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Color(0xFF025464),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(top: 9),
                                child: Text(
                                  formattedDate,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF025464),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(top: 5),
                                child: Text(
                                  message,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF025464),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(top: 5),
                                child: Text(
                                  formattedTime,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF025464),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox
                      .shrink(); // Item-item setelah 19 akan diabaikan
                }
              },
            );
          },
        ),
      ),
    );
  }
}
