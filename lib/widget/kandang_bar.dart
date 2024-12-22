import 'package:flutter/material.dart';
import '../models/kandang_model.dart';
import '../datas/dummy.dart';
// import 'package:adem/datas/dummy.dart';
// import 'package:adem/models/kandang_model.dart';

class KandangBar extends StatefulWidget {
  final int selected;
  final Function(int) onSelect;
  final Function() onAddKandang;

  const KandangBar({
    super.key,
    required this.selected,
    required this.onSelect,
    required this.onAddKandang,
  });

  @override
  // ignore: library_private_types_in_public_api
  _KandangBarState createState() => _KandangBarState();

  static void addKandang() {}
}

class _KandangBarState extends State<KandangBar> {
  var selected = 0;
  void addKandang() {
    // Get the number of existing kandangs
    int numberOfKandangs = kandangs.length;

    // Create a new kandang with an incremented name
    Kandang newKandang = Kandang(
      name: "Kandang ${numberOfKandangs + 1}",
      nodes: [], // Initialize nodes as empty for now
    );

    // Add the new kandang to the list
    setState(() {
      kandangs.add(newKandang);
      selected = kandangs.length - 1; // Select the newly added kandang
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(
        20,
        40,
        0,
        0,
      ),
      width: double.infinity,
      height: 41,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    widget.onSelect(index);
                  },
                  child: Container(
                    margin: const EdgeInsetsDirectional.fromSTEB(
                      10,
                      0,
                      0,
                      0,
                    ),
                    height: 41,
                    width: 130,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: widget.selected == index
                          ? const Color(0xFF025464)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      kandangs[index].name, // Use your actual data source here
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.selected == index
                            ? Colors.white
                            : const Color(0xFF025464),
                      ),
                    ),
                  ),
                );
              },
              itemCount:
                  kandangs.length, // Use your actual data source length here
            ),
          ),
          GestureDetector(
            onTap: widget.onAddKandang,
            child: Container(
              margin: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              width: 41,
              height: 41,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
