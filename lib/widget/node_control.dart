// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import '../models/kandang_model.dart';
// import '../services/database.dart';

// class MonitorSuhu extends StatefulWidget {
//   const MonitorSuhu({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _MonitorSuhu createState() => _MonitorSuhu();
// }

// class _MonitorSuhu extends State<MonitorSuhu> {
//   // Declare your variables here
//   List<Kandang> kandangs = []; // Initialize this list with your data
//   int selected = 0; // Initialize the selected index
//   @override
//   void initState() {
//     super.initState();
//     fetchKandangsFromFirebase(); // Fetch data when the widget initializes
//   }

//   Future<void> fetchKandangsFromFirebase() async {
//     FirebaseService firebaseService = FirebaseService();
//     try {
//       List<Kandang> fetchedKandangs = await firebaseService.fetchKandangs();
//       setState(() {
//         kandangs = fetchedKandangs;
//       });
//     } catch (error) {
//       if (kDebugMode) {
//         print('Error fetching kandangs: $error');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     //var suhu = kandangs.isNotEmpty ? kandangs[selected].averageValue.suhu : '';

//     return 
