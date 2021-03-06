import 'package:atenciones/main.dart';
import 'package:flutter/material.dart';

class HealthCareMain extends StatelessWidget {
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
        child: RaisedButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Atenciones en salud',
                  // style: TextStyle(color: Colors.white)
                  style: Theme.of(context).textTheme.headline5),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HealthAppointments()));
            }),
      ),
    );
  }
}
