import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './models/appointments.dart';
import './screens/appointments_list.dart';
import './screens/new_appointment.dart';
import 'screens/appointment_main.dart';
// import './screens/show_gif.dart';
import './screens/health_care_main.dart';

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
        initialRoute: HealthCareMain.id,
        routes: {
          HealthCareMain.id: (context) => HealthCareMain(),
          HealthAppointments.id: (context) => HealthAppointments(),
          AppointmentMain.id: (context) => AppointmentMain(),
        });
  }
}

class HealthAppointments extends StatefulWidget {
  static const id = 'health_appointments';
  final String title = "Atenciones en salud";

  @override
  _HealthAppointmentsState createState() => _HealthAppointmentsState();
}

class _HealthAppointmentsState extends State<HealthAppointments> {
  int _contId = 4;
  int _bottomNavigationIndex = 0;
  // int _contId = 0;
  String _gif = 'images/pending_appointments.gif';

  List<Appointment> presentAppointments = [
    Appointment(
      id: 0,
      type: 'Medicina general',
      place: 'HGM',
      additionalInformation: ':)',
      date: DateTime.now().add(Duration(hours: 2)),
      time: TimeOfDay.now(),
    ),
    Appointment(
      id: 2,
      type: 'Odontología',
      place: 'HGM',
      additionalInformation: ':)',
      date: DateTime.now().add(Duration(days: 11)),
      time: TimeOfDay.now(),
    ),
  ];

  List<Appointment> pastAppointments = [
    Appointment(
      id: 1,
      type: 'Medicina general',
      place: 'CES Sabaneta',
      additionalInformation: ':)',
      date: DateTime.now().subtract(Duration(days: 12)),
      time: TimeOfDay.now(),
    ),
    Appointment(
      id: 3,
      type: 'Odontología',
      place: 'CES Sabaneta',
      additionalInformation: ':)',
      date: DateTime.now().subtract(Duration(days: 4)),
      time: TimeOfDay.now(),
    ),
  ];
  List<Appointment> renderList = [];

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
      //Solo past y present cuando se añade, no "actualiza"
      if (_date.isAfter(DateTime.now())) {
        presentAppointments.add(newAppointment);
      } else {
        pastAppointments.add(newAppointment);
      }
      pastAppointments.sort((a, b) => a.date.compareTo(b.date));
      presentAppointments.sort((a, b) => a.date.compareTo(b.date));
    });
  }

  void _deleteAppointment(int id) {
    setState(() {
      //Not great but works
      pastAppointments.removeWhere((appointment) => appointment.id == id);
      presentAppointments.removeWhere((appointment) => appointment.id == id);
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

  void _gifForType(String type) {
    setState(() {
      if (type == 'Medicina general') {
        _gif = 'images/practice2_GIF.gif';
      } else {
        _gif = 'images/practice_GIF.gif';
      }
    });
  }

  _selectAppointmentList(int index) {
    setState(() {
      _gif = 'images/practice_GIF.gif';
      if (index == 0) {
        renderList = presentAppointments;
        _bottomNavigationIndex = 0;
      } else {
        renderList = pastAppointments;
        _bottomNavigationIndex = 1;
      }
    });
  }

  @override
  void initState() {
    renderList = presentAppointments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: SafeArea(
        // child: TabsScreen(),
        //   ),
        // );
        child: Column(
          //No sé si necesito esto
          children: [
            //GIF and add
            GifAndButtons(_gif, _startAddNewAppointment, Icon(Icons.add),
                () => {}, Icon(Icons.check), _gifForType),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    AppointmentsList(
                        renderList, _deleteAppointment, _gifForType),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        onTap: _selectAppointmentList,
        currentIndex: _bottomNavigationIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Pendientes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Historial',
          ),
        ],
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class GifAndButtons extends StatefulWidget {
  final String gif;
  final Function topButtonFunction;
  final Icon topButtonIcon;
  final Function bottomButtonFunction;
  final Icon bottomButtonIcon;
  final Function gifFunction;

  GifAndButtons(this.gif, this.topButtonFunction, this.topButtonIcon,
      this.bottomButtonFunction, this.bottomButtonIcon, this.gifFunction);

  @override
  _GifAndButtonsState createState() => _GifAndButtonsState();
}

class _GifAndButtonsState extends State<GifAndButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: ShowGIF(widget.gif),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                heroTag: 'add_appointment',
                elevation: 5,
                child: GestureDetector(
                  child: widget.topButtonIcon,
                  onDoubleTap: () => widget.topButtonFunction(context),
                ),
                onPressed: () {
                  widget.gifFunction('general_medicine');
                },
              ),
              FloatingActionButton(
                heroTag: 'accept',
                elevation: 5,
                child: GestureDetector(
                  child: widget.bottomButtonIcon,
                  onDoubleTap: () => null,
                ),
                onPressed: () {
                  widget.gifFunction('odontology');
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
