class Kandang {
  final String name;
  final List<Node> nodes;
  late final Value averageValue; // Tambah variabel rata-rata

  Kandang({required this.name, required this.nodes}) {
    calculateAverageValue(); // Hitung rata-rata saat inisialisasi
  }

  void calculateAverageValue() {
    double totalSuhu = 0.0;
    double totalKelembaban = 0.0;
    for (var node in nodes) {
      totalSuhu += double.parse(node.value.suhu);
      totalKelembaban += double.parse(node.value.kelembaban);
    }

    double averageSuhu = totalSuhu / nodes.length;
    double averageKelembaban = totalKelembaban / nodes.length;

    averageValue = Value(
      suhu: averageSuhu.toStringAsFixed(1),
      kelembaban: averageKelembaban.toStringAsFixed(1),
    );
  }
}

class Node {
  final String name;
  final Value value;
  final bool relay;

  Node({required this.name, required this.value, required this.relay});
}

class Value {
  final String suhu;
  final String kelembaban;

  Value({required this.suhu, required this.kelembaban});
}
