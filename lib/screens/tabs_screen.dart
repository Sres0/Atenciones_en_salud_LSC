// import './appointments_list.dart';
import './past_appointments.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  // final List allAppointments;
  // final Function deleteAppointment;
  // final Function urlGIFType;

  // TabsScreen(this.allAppointments, this.deleteAppointment, this.urlGIFType);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  // List _allAppointments;
  // Function _deleteAppointment;
  // Function _urlGIFType;

  // @override
  // void initState() {
  //   _allAppointments = widget.allAppointments;
  //   _deleteAppointment = widget.deleteAppointment;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'Pendientes', icon: Icon(Icons.calendar_today)),
              Tab(text: 'Historial', icon: Icon(Icons.lock_clock)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // AppointmentsList(widget.allAppointments, widget.deleteAppointment,
            // widget.urlGIFType),
            PastAppointments(),
            PastAppointments(),
          ],
        ),
      ),
    );
  }
}
