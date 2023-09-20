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
  final TextStyle _selectedlabelStyle = const TextStyle(
    color: Color(0xFF025464),
    fontSize: 10.0, // Change the color here
  );

    final TextStyle _unselectedlabelStyle = const TextStyle(
    color: Colors.grey,
    fontSize: 10.0, // Change the color here
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Background color
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home,
              color: _currentIndex == 0 ? const Color(0xFF025464) : Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Tools',
            icon: Icon(
              Icons.phonelink_ring,
              color: _currentIndex == 1 ? const Color(0xFF025464) : Colors.grey,
            ),
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
        selectedItemColor: const Color(0xFF025464),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: _selectedlabelStyle,
        unselectedLabelStyle: _unselectedlabelStyle,
      ),
    );
  }
}
