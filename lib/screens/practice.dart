import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/appointments.dart';
import 'package:atenciones/screens/appointments_list.dart';
import 'package:atenciones/screens/new_appointment.dart';
// import 'package:atenciones/screens/show_gif.dart';
import '../health_care_main.dart';

// import 'package:atenciones/screens/practice.dart';

// import 'dart:html';
// import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(AppLSCAES());
}

class AppLSCAES extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atenciones en salud',
      home: HealthCareMain(),
    );
  }
}

class HealthAppointments extends StatefulWidget {
  final String title = "Atenciones en salud";

  @override
  _HealthAppointmentsState createState() => _HealthAppointmentsState();
}

class _HealthAppointmentsState extends State<HealthAppointments> {
  // final List<Appointment> _allAppointments;
  int _contId = 0;
  String _gif = 'images/practice_GIF.gif';
  List<Appointment> _allAppointments = [];

  void _addNewAppointment(
    String _type,
    String _place,
    String _additionalInformation,
    DateTime _date,
    TimeOfDay _time,
  ) {
    final newAppointment = Appointment(
      id: _contId,
      type: _type,
      place: _place,
      additionalInformation: _additionalInformation,
      date: _date,
      time: _time,
    );

    _contId++;

    setState(() {
      _allAppointments.add(newAppointment);
      _allAppointments.sort((a, b) => a.date.compareTo(b.date));
    });
  }

  void _editInformation(int id) {
    setState(() {
      _allAppointments.removeWhere((appointment) => appointment.id == id);
    });
    return;
  }

  void _startAddNewAppointment(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewAppointment(_addNewAppointment),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _imageForType(String type) {
    setState(() {
      if (type.toUpperCase() == 'MEDICINA GENERAL') {
        _gif = 'images/practice2_GIF.gif';
      } else {
        _gif = 'images/practice_GIF.gif';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    AppointmentsList(
                        _allAppointments, _editInformation, _imageForType),
                  ],
                ),
              ),
            ),
            Container(
              height: mediaQuery.size.height * 0.3,
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: ShowGIF(_gif),
                  ),
                  FloatingActionButton(
                    child: Icon(
                      Icons.add,
                    ),
                    onPressed: () => _startAddNewAppointment(context),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
