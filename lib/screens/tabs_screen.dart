// import './appointments_list.dart';
// import './past_appointments.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  _selectPage(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: null,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Pendientes',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.lock_clock), label: 'Historial'),
        ],
      ),
    );
  }
}
