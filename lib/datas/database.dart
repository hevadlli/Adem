import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:adem/models/kandang_model.dart'; // Import your model classes

class FirestoreDataManager {
  List<Kandang> kandangs = [];

  FirestoreDataManager() {
    fetchData();
  }

  Future<void> fetchData() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('kandangs').get();

    for (var doc in snapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      List<Node> nodes = [];
      for (var nodeData in data['Node']) {
        nodes.add(
          Node(
            name: nodeData['name'],
            value: Value(
              suhu: nodeData['value']['temp'],
              kelembaban: nodeData['value']['hum'],
            ),
            relay: nodeData['relay'],
          ),
        );
      }
      kandangs.add(
        Kandang(
          name: data['name'],
          nodes: nodes,
        ),
      );
    }
  }
}
