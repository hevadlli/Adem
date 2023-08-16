import 'package:flutter/material.dart';
import 'package:adem/datas/database.dart';
import 'package:adem/models/kandang_model.dart';
import 'package:adem/widget/app_bar.dart';
import 'package:adem/widget/kandang_bar.dart';

class ToolPage extends StatefulWidget {
  const ToolPage({super.key});

  @override
  State<ToolPage> createState() {
    return _ToolPageState();
  }
}

class _ToolPageState extends State<ToolPage> {
  final FirestoreDataManager firestoreData = FirestoreDataManager();

  @override
  void initState() {
    super.initState();
    firestoreData.fetchData();
  }

  var selected = 0;

  bool manualMode = false; // Initial state of manual mode

  void addNode() {
    // Get the number of existing nodes for the selected kandang
    int numberOfNodes = firestoreData.kandangs[selected].nodes.length;

    // Create a new node with an incremented name
    Node newNode = Node(
        name: "Node ${numberOfNodes + 1}",
        value: Value(suhu: "0", kelembaban: "0"),
        relay: false);

    // Add the new node to the selected kandang's nodes list
    setState(() {
      firestoreData.kandangs[selected].nodes.add(newNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            KandangBar(
              selected: selected,
              onSelect: (index) {
                setState(() {
                  selected = index;
                });
              },
              onAddKandang: () {
                setState(() {
                  KandangBar.addKandang(); // Call the addKandang function here
                });
              },
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    30,
                    40,
                    5,
                    40,
                  ),
                  child: Text(
                    "Manual Mode",
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF025464),
                    ),
                  ),
                ),
                Switch(
                  value: manualMode,
                  onChanged: (value) {
                    setState(() {
                      manualMode = value;
                    });
                  },
                  activeColor: const Color(0xFF025464),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
                child: ListView.builder(
                  itemCount: firestoreData.kandangs[selected].nodes.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      margin: const EdgeInsetsDirectional.symmetric(
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              firestoreData
                                  .kandangs[selected].nodes[index].name,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Color(0xFF025464),
                              ),
                            ),
                            manualMode
                                ? const Switch(
                                    value: false,
                                    onChanged: null, // Disable switch
                                    activeColor: Color(0xFF025464),
                                  )
                                : Switch(
                                    value:
                                        false, // You can set the initial value here
                                    onChanged: (value) {
                                      // Handle switch state change for node
                                    },
                                    activeColor: const Color(0xFF025464),
                                  ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: manualMode
            ? null // If manual mode is active, hide the floating action button
            : FloatingActionButton(
                onPressed: () {
                  addNode();
                },
                backgroundColor: const Color(0xFF025464),
                child: const Icon(Icons.add),
              ),
      ),
    );
  }
}
