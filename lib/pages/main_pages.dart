import 'package:flutter/material.dart';
import 'package:adem/pages/home_page.dart';
import 'package:adem/pages/chart_pages.dart';
import 'package:adem/pages/tools_pages.dart';
import 'package:adem/pages/history_pages.dart';

class MainPages extends StatefulWidget {
  const MainPages({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPagesState createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ToolPage(),
    const ChartPage(),
    const HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _currentIndex == 0 ? const Color(0xFF025464) : Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.build,
              color: _currentIndex == 1 ? const Color(0xFF025464) : Colors.grey,
            ),
            label: 'Tools',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.insert_chart,
              color: _currentIndex == 2 ? const Color(0xFF025464) : Colors.grey,
            ),
            label: 'Chart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
              color: _currentIndex == 3 ? const Color(0xFF025464) : Colors.grey,
            ),
            label: 'History',
          ),
        ],
        backgroundColor: Colors.white, // Background color
      ),
    );
  }
}
