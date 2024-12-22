import 'package:flutter/material.dart';
import 'main_pages.dart'; // Import the MainPages

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // Call a function to navigate to the main content after a delay
    navigateToMainContent();
  }

  void navigateToMainContent() {
    // Delay for 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the main content (MainPages)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPages()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF025464),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/LogoAdemOr.png', // Replace with your logo asset path
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(), // Loading indicator
          ],
        ),
      ),
    );
  }
}
