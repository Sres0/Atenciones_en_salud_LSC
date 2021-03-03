import 'package:flutter/material.dart';

import './models/appointments.dart';
import 'package:atenciones/screens/appointments_list.dart';
import 'package:atenciones/screens/new_appointment.dart';
// import 'package:atenciones/screens/show_gif.dart';
import './health_care_main.dart';

// import 'package:atenciones/screens/practice.dart';

// import 'dart:html';
// import 'package:intl/intl.dart';

void main() => runApp(AppLSCAES());

class AppLSCAES extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atenciones en salud',
      home: HealthCareMain(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[600],
        primaryColorDark: Colors.lightBlue[900],
        primaryColorLight: Colors.blue[50],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
              color: Theme.of(context).primaryColor,
              textTheme: TextTheme(
                headline4:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              actionsIconTheme: Theme.of(context).iconTheme,
            ),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(color: Colors.white),
              headline2: TextStyle(color: Colors.white),
              headline3: TextStyle(color: Colors.white),
              headline4: TextStyle(color: Colors.grey),
              headline5: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue[900],
              ),
              headline6: TextStyle(color: Colors.lightBlue[900]),
              subtitle1: TextStyle(color: Colors.lightBlue[900]),
              subtitle2: TextStyle(color: Colors.blue[600]),
            ),
        iconTheme: ThemeData.light().iconTheme.copyWith(
              color: Colors.white,
              // opacity: 10.5,
            ),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          minWidth: 100.0,
          height: 40.0,
        ),
      ),
      // home: HealthAppointments(title: 'Atenciones en salud'),
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

  final List<Appointment> _allAppointments = [
    // Appointment(
    //   id: 1,
    //   date: DateTime.now().subtract(Duration(days: 5, hours: 2)),
    //   time: TimeOfDay.now(),
    //   type: "Medicina general",
    //   place: "HGM",
    // ),
    // Appointment(
    //   id: 2,
    //   date: DateTime.now().subtract(Duration(days: 10, hours: 5)),
    //   time: TimeOfDay.now(),
    //   type: "Odontología",
    //   place: "CES Sabaneta",
    // ),
    // Appointment(
    //   id: 3,
    //   date: DateTime.now().subtract(Duration(days: 20, hours: 15)),
    //   time: TimeOfDay.now(),
    //   type: "Medicina general",
    //   place: "CVZ",
    // ),
    // Appointment(
    //   id: 4,
    //   date: DateTime.now().subtract(Duration(days: 50, hours: 1)),
    //   time: TimeOfDay.now(),
    //   type: "Medicina general",
    //   place: "HGM",
    // ),
    // Appointment(
    //   id: 5,
    //   date: DateTime.now().subtract(Duration(days: 3, hours: 2)),
    //   time: TimeOfDay.now(),
    //   type: "Odontología",
    //   place: "CES Sabaneta",
    // ),
    // Appointment(
    //   id: 6,
    //   date: DateTime.now().subtract(Duration(days: 0)),
    //   time: TimeOfDay.now(),
    //   type: "Odontología",
    //   place: "CES Prado",
    // ),
  ];

  // _HealthAppointmentsState(this._allAppointments, this._cont);
  // _HealthAppointmentsState(this._allAppointments);

  void _addNewAppointment(
      String _type, String _place, DateTime _date, TimeOfDay _time) {
    final newAppointment = Appointment(
      id: _contId,
      type: _type,
      place: _place,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: Theme.of(context).appBarTheme.textTheme.headline4),
      ),
      body: Column(
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
                    color: Theme.of(context).iconTheme.color,
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () => _startAddNewAppointment(context),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
