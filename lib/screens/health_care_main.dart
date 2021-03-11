import 'package:atenciones/main.dart';
import 'package:flutter/material.dart';

class HealthCareMain extends StatelessWidget {
  static const id = 'health_care_main';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            return;
          },
        ),
        title: Text('Menú'),
      ),
      body: Center(
        child: ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Atenciones en salud',
                // style: TextStyle(color: Colors.white)
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, HealthAppointments.id);
            }),
      ),
    );
  }
}
