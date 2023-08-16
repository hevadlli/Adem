import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HumidityScreen extends StatefulWidget {
  const HumidityScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HumidityScreenState createState() => _HumidityScreenState();
}

class _HumidityScreenState extends State<HumidityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Kelembaban')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('esp32_hum1').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final humidityData =
              snapshot.data?.docs; // List of QueryDocumentSnapshot

          return ListView.builder(
            itemCount: humidityData?.length,
            itemBuilder: (context, index) {
              final doc = humidityData?[index];
              final humidityValue = doc?['data'];
              return ListTile(
                title: Text('Kelembaban: $humidityValue'),
              );
            },
          );
        },
      ),
    );
  }
}
