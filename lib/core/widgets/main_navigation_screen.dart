// lib/core/widgets/main_navigation_screen.dart
import 'package:flutter/material.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/notes/presentation/screens/note_screen.dart';
import '../../features/todo/presentation/screens/todo_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State {
  // Index untuk menandai tab mana yang sedang aktif
  int _currentIndex = 0;

  // Daftar screen dari masing-masing fitur
  final List _screens = const [
    DashboardScreen(),
    TodoScreen(),
    NoteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menampilkan screen sesuai tab yang dipilih
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Ubah tab saat diklik
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outlined),
            activeIcon: Icon(Icons.check_box),
            label: 'To-Do',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_outlined),
            activeIcon: Icon(Icons.note),
            label: 'Notes',
          ),
        ],
      ),
    );
  }
}