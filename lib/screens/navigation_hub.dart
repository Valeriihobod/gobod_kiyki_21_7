import 'package:flutter/material.dart';
import 'faculty_dashboard.dart';
import 'learner_list.dart';

class NavigationHub extends StatefulWidget {
  const NavigationHub({super.key});

  @override
  State<NavigationHub> createState() => _NavigationHubState();
}

class _NavigationHubState extends State<NavigationHub> {
  int _currentTabIndex = 0;

  final List<Widget> _tabs = [
    const FacultyDashboard(),
    const LearnerList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: 'Faculties'),
          BottomNavigationBarItem(icon: Icon(Icons.person_2), label: 'Learners'),
        ],
      ),
    );
  }
}
