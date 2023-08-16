// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() {
//     return _HomePageState();
//   }
// }

// class _HomePageState extends State<HomePage> {
//   final List kandang = [
//     "Kandang 1",
//     "Kandang 2",
//     "Kandang 3",
//     "Kandang 4",
//   ];
//   final List node = [
//     "Node 1",
//     "Node 2",
//     "Node 3",
//   ];
//   final List valuesuhu = [
//     "27,3",
//     "26,7",
//     "25,8",
//   ];
//   final List valuekel = [
//     "85,3",
//     "83,1",
//     "85,4",
//   ];
//   var selected = 0;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: const Color(0xFFF6F6F6),
//         appBar: AppBar(
//           title: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Image.asset(
//               'assets/images/LogoAdemHi.png',
//               width: 90,
//               height: 200,
//             ),
//           ),
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 margin: const EdgeInsetsDirectional.fromSTEB(
//                   20,
//                   40,
//                   0,
//                   0,
//                 ),
//                 width: double.infinity,
//                 height: 41,
//                 decoration: const BoxDecoration(
//                   color: Colors.transparent,
//                 ),
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: const EdgeInsetsDirectional.fromSTEB(
//                         10,
//                         0,
//                         0,
//                         0,
//                       ),
//                       height: 41,
//                       width: 130,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         color: selected == index
//                             ? const Color(0xFF025464)
//                             : Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text(
//                         kandang[index],
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: selected == index
//                               ? Colors.white
//                               : const Color(0xFF025464),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(15, 30, 15, 15),
//                 child: Material(
//                   elevation: 4,
//                   borderRadius: const BorderRadius.all(Radius.circular(20)),
//                   color: Colors.transparent,
//                   child: Container(
//                     height: 305,
//                     width: 350,
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(20),
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         const Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(
//                             15,
//                             20,
//                             0,
//                             0,
//                           ),
//                           child: Row(
//                             children: [
//                               Text(
//                                 "Suhu",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Color(0xFF025464),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(
//                             15,
//                             10,
//                             0,
//                             0,
//                           ),
//                           child: Row(
//                             children: [
//                               Text(
//                                 "26,6",
//                                 style: TextStyle(
//                                   fontSize: 48,
//                                   color: Color(0xFF025464),
//                                 ),
//                               ),
//                               Padding(
//                                 padding:
//                                     EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//                                 child: Text(
//                                   "°C",
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     color: Color(0xFF025464),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: const EdgeInsetsDirectional.fromSTEB(
//                             10,
//                             20,
//                             10,
//                             10,
//                           ),
//                           width: double.infinity,
//                           height: 145,
//                           decoration: const BoxDecoration(
//                             color: Colors.transparent,
//                           ),
//                           child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context, index) {
//                               return Container(
//                                 margin: const EdgeInsetsDirectional.fromSTEB(
//                                   10,
//                                   0,
//                                   0,
//                                   0,
//                                 ),
//                                 height: 145,
//                                 width: 110,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFF025464),
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsetsDirectional
//                                               .fromSTEB(
//                                             15,
//                                             10,
//                                             0,
//                                             0,
//                                           ),
//                                           child: Text(
//                                             node[index],
//                                             style: const TextStyle(
//                                               fontSize: 15,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsetsDirectional
//                                               .fromSTEB(
//                                             15,
//                                             30,
//                                             0,
//                                             0,
//                                           ),
//                                           child: Text(
//                                             valuesuhu[index],
//                                             style: const TextStyle(
//                                               fontSize: 30,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                             itemCount: node.length,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 30),
//                 child: Material(
//                   elevation: 4,
//                   borderRadius: const BorderRadius.all(Radius.circular(20)),
//                   color: Colors.transparent,
//                   child: Container(
//                     height: 305,
//                     width: 350,
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(20),
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         const Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(
//                             15,
//                             20,
//                             0,
//                             0,
//                           ),
//                           child: Row(
//                             children: [
//                               Text(
//                                 "Kelembaban",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Color(0xFF025464),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(
//                             15,
//                             10,
//                             0,
//                             0,
//                           ),
//                           child: Row(
//                             children: [
//                               Text(
//                                 "84,6",
//                                 style: TextStyle(
//                                   fontSize: 48,
//                                   color: Color(0xFF025464),
//                                 ),
//                               ),
//                               Padding(
//                                 padding:
//                                     EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//                                 child: Text(
//                                   "%",
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     color: Color(0xFF025464),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: const EdgeInsetsDirectional.fromSTEB(
//                             10,
//                             20,
//                             10,
//                             10,
//                           ),
//                           width: double.infinity,
//                           height: 145,
//                           decoration: const BoxDecoration(
//                             color: Colors.transparent,
//                           ),
//                           child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context, index) {
//                               return Container(
//                                 margin: const EdgeInsetsDirectional.fromSTEB(
//                                   10,
//                                   0,
//                                   0,
//                                   0,
//                                 ),
//                                 height: 145,
//                                 width: 110,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFF025464),
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsetsDirectional
//                                               .fromSTEB(
//                                             15,
//                                             10,
//                                             0,
//                                             0,
//                                           ),
//                                           child: Text(
//                                             node[index],
//                                             style: const TextStyle(
//                                               fontSize: 15,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsetsDirectional
//                                               .fromSTEB(
//                                             15,
//                                             30,
//                                             0,
//                                             0,
//                                           ),
//                                           child: Text(
//                                             valuekel[index],
//                                             style: const TextStyle(
//                                               fontSize: 30,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                             itemCount: node.length,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
