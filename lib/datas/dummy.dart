import 'package:adem/models/kandang_model.dart';

// Dummy data
final List<Kandang> kandangs = [
  Kandang(
    name: "Kandang 1",
    nodes: [
      Node(
          name: "Node 1",
          value: Value(suhu: "27.3", kelembaban: "85.3"),
          relay: false),
      Node(
          name: "Node 2",
          value: Value(suhu: "26.7", kelembaban: "83.1"),
          relay: true),
      // Add more nodes here
    ],
  ),
  Kandang(
    name: "Kandang 2",
    nodes: [
      Node(
          name: "Node 1",
          value: Value(suhu: "25.8", kelembaban: "85.4"),
          relay: false),
      // Add more nodes here
    ],
  ),
  // Add more kandangs here
];
