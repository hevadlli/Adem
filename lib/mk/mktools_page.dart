// import 'package:flutter/material.dart';

// class ToolPage extends StatefulWidget {
//   const ToolPage({super.key});

//   @override
//   State<ToolPage> createState() {
//     return _ToolPageState();
//   }
// }

// class _ToolPageState extends State<ToolPage> {
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
//   var selected = 0;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
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
//         // body: SingleChildScrollView(
//         //   child:
//         body: Column(
//           children: [
//             Container(
//               margin: const EdgeInsetsDirectional.fromSTEB(
//                 20,
//                 40,
//                 0,
//                 0,
//               ),
//               width: double.infinity,
//               height: 41,
//               decoration: const BoxDecoration(
//                 color: Colors.transparent,
//               ),
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     margin: const EdgeInsetsDirectional.fromSTEB(
//                       10,
//                       0,
//                       0,
//                       0,
//                     ),
//                     height: 41,
//                     width: 130,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: selected == index
//                           ? const Color(0xFF025464)
//                           : Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       kandang[index],
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: selected == index
//                             ? Colors.white
//                             : const Color(0xFF025464),
//                       ),
//                     ),
//                   );
//                 },
//                 itemCount: kandang.length,
//               ),
//             ),
//             const Row(
//               children: [
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(
//                     30,
//                     40,
//                     30,
//                     40,
//                   ),
//                   child: Text(
//                     "Manual Mode",
//                     style: TextStyle(
//                       fontSize: 24,
//                       color: Color(0xFF025464),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
//                 child: ListView.builder(
//                   itemCount: node.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       height: 100,
//                       margin: const EdgeInsetsDirectional.symmetric(
//                         vertical: 10,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: ListTile(
//                         title: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             node[index],
//                             style: const TextStyle(
//                               fontSize: 24,
//                               color: Color(0xFF025464),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
