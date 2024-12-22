// import 'package:adem/pages/mkhome_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class LoadingPage extends StatefulWidget {
//   const LoadingPage({super.key});

//   @override
//   State<LoadingPage> createState() {
//     return _LoadingPageState();
//   }
// }

// class _LoadingPageState extends State<LoadingPage> {
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
//     Future.delayed(const Duration(seconds: 3)).then((value) {
//       Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(
//             builder: (context) => const HomePage(),
//           ),
//           (route) => false);
//     });
//     return Scaffold(
//       backgroundColor: const Color(0xFF025464),
//       body: SizedBox(
//         height: double.infinity,
//         width: double.infinity,
//         child: Stack(
//           children: [
//             Opacity(
//               opacity: 0.1,
//               child: Image.asset(
//                 'assets/images/ayam.png',
//                 width: double.infinity,
//                 height: double.infinity,
//               ),
//             ),
//             SafeArea(
//               child: Align(
//                 alignment: const AlignmentDirectional(0, 0),
//                 child: Image.asset(
//                   'assets/images/LogoAdemOr.png',
//                   width: 228,
//                   height: 56,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
