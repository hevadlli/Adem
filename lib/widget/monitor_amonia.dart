// import 'package:flutter/material.dart';
// import '../datas/dummy.dart';

// class MonitorAmonia extends StatefulWidget {
//   const MonitorAmonia({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _MonitorAmonia createState() => _MonitorAmonia();
// }

// class _MonitorAmonia extends State<MonitorAmonia> {
//   // Declare your variables here
//   var selected = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 30),
//       child: Material(
//         elevation: 4,
//         borderRadius: const BorderRadius.all(Radius.circular(20)),
//         color: Colors.transparent,
//         child: Container(
//           height: 305,
//           width: 350,
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.all(
//               Radius.circular(20),
//             ),
//           ),
//           child: Column(
//             children: [
//               const Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(
//                   15,
//                   20,
//                   0,
//                   0,
//                 ),
//                 child: Row(
//                   children: [
//                     Text(
//                       "Amonia",
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Color(0xFF025464),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(
//                   15,
//                   10,
//                   0,
//                   0,
//                 ),
//                 child: Row(
//                   children: [
//                     Text(
//                       kandangs[selected].averageValue.Amonia as String,
//                       style: const TextStyle(
//                         fontSize: 48,
//                         color: Color(0xFF025464),
//                       ),
//                     ),
//                     const Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//                       child: Text(
//                         "%",
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Color(0xFF025464),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsetsDirectional.fromSTEB(
//                   10,
//                   20,
//                   10,
//                   10,
//                 ),
//                 width: double.infinity,
//                 height: 145,
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
//                       height: 145,
//                       width: 110,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF025464),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsetsDirectional.fromSTEB(
//                                   15,
//                                   10,
//                                   0,
//                                   0,
//                                 ),
//                                 child: Text(
//                                   kandangs[selected].nodes[index].name,
//                                   style: const TextStyle(
//                                     fontSize: 15,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsetsDirectional.fromSTEB(
//                                   15,
//                                   30,
//                                   0,
//                                   0,
//                                 ),
//                                 child: Text(
//                                   kandangs[selected].nodes[index].value.Amonia,
//                                   style: const TextStyle(
//                                     fontSize: 30,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   itemCount: kandangs[selected].nodes.length,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
