import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_gifimage/flutter_gifimage.dart';
// import 'package:flutter_material_pickers/flutter_material_pickers.dart';

class NewAppointment extends StatefulWidget {
  final Function newAppointment;

  NewAppointment(this.newAppointment);

  @override
  _NewAppointmentState createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  String _selectedType;
  // String _selectedType = "Odontología";
  DateTime _selectedDate;
  TimeOfDay _selectedTime;
  String _gif = 'images/practice_GIF.gif';
  final _place = TextEditingController();
  final _additionalInformation = TextEditingController();

  List<String> types = <String>[
    'Enfermería',
    'Fisioterapia',
    'Fonoaudiología',
    'Medicina especializada',
    'Medicina general',
    'Nutrición',
    'Odontología',
    'Odontología especializada',
    'Optometría',
    'Psicología',
    'Química farmacéutica',
    'Terapia ocupacional',
    'Terapia respiratoria',
  ];

  void _submitData() {
    final selectedPlace = _place.text;
    final selectedAdditionalInformation = _additionalInformation.text;

    if (_selectedDate == null || _selectedTime == null || selectedPlace == '') {
      return;
    }

    widget.newAppointment(
      _selectedType,
      selectedPlace,
      selectedAdditionalInformation,
      _selectedDate,
      _selectedTime,
    );

    Navigator.of(context).pop();
  }

  void _selectDate() {
    DateTime dateTimeNow = DateTime.now();
    showDatePicker(
      context: context,
      initialDate: dateTimeNow,
      firstDate: dateTimeNow.subtract(Duration(days: 900)),
      lastDate: dateTimeNow.add(Duration(days: 900)),
    ).then((selectedDate) {
      if (selectedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = selectedDate;
      });
    });

    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((selectedTime) {
      if (selectedTime == null) {
        return;
      }
      setState(() {
        _selectedTime = selectedTime;
      });
    });
  }

  void _gifForNAField(String field) {
    setState(() {
      if (field == 'type' || field == 'place') {
        _gif = 'images/practice2_GIF.gif';
      } else {
        _gif = 'images/practice_GIF.gif';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //GIFs
              ShowGIF(_gif),

              //SELECT TYPE OF ATTENTION -- No double tap yet
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Theme.of(context).primaryColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Container(
                            width: 150, //and here
                            child: GestureDetector(
                              child: Text(
                                "Tipo de cita",
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          onTap: () {
                            _gifForNAField('type');
                          },
                          value: _selectedType,
                          onChanged: (selection) {
                            setState(() {
                              _selectedType = selection;
                            });
                          },
                          items: types.map((String type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(
                                type,
                                textAlign: TextAlign.start,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),

                  //DATE
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          _selectedDate == null
                              ? "Aún no has elegido fecha!"
                              : "Fecha: ${DateFormat.yMd().format(_selectedDate)}",
                        ),
                        TextButton(
                          child: GestureDetector(
                            child: Text(
                              "Elegir fecha y hora",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onDoubleTap: () => _selectDate(),
                          ),
                          onPressed: () {
                            _gifForNAField('date');
                          },
                        )
                      ],
                    ),
                  ),

                  //SELECT PLACE -- No double tap yet
                  Container(
                    child: TextField(
                      onTap: () => _gifForNAField('place'),
                      keyboardType: TextInputType.text,
                      controller: _place,
                      decoration: InputDecoration(
                        labelText: "Lugar",
                        helperText: "Ejemplo: HGM, IPS CES Sabaneta",
                      ),
                    ),
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  ),

                  //ADDITIONAL INFO -- No double tap yet
                  Container(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: _additionalInformation,
                      decoration: InputDecoration(
                        labelText: 'Información adicional (opcional)',
                        helperText: 'Ejemplo: Nombre del profesional de salud.',
                      ),
                      onTap: () {
                        _gifForNAField('additionalInformation');
                      },
                    ),
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  ),
                ],
              ),

              Container(
                padding: EdgeInsets.all(5),
                child: ElevatedButton(
                  child: Text('Añadir cita'),
                  onPressed: _submitData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ShowGIF extends StatefulWidget {
//   final String gif;

//   ShowGIF(this.gif);

//   @override
//   _ShowGIFState createState() => _ShowGIFState();
// }

// class _ShowGIFState extends State<ShowGIF> with TickerProviderStateMixin {
//   GifController controller;
//   String gif;

//   @override
//   void initState() {
//     controller = GifController(vsync: this);
//     super.initState();
//   }

//   playGif(String gifToPlay) {
//     setState(() {
//       gif = gifToPlay;
//     });
//     controller.value = 0;
//     controller.animateTo(23,
//         duration: Duration(milliseconds: (140 * 25).toInt()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Container(
//         height: 170,
//         padding: EdgeInsets.only(right: 20.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Card(
//               child: GifImage(
//                 controller: controller,
//                 image: AssetImage(widget.gif),
//               ),
//               elevation: 7,
//             ),
//           ],
//         ),
//       ),
//       onDoubleTap: playGif(widget.gif),
//     );
//     // );
//   }
// }

//     GestureDetector(
//       onTap: playGif(widget.gif),
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         child: GifImage(
//           controller: controller,
//           image: AssetImage(widget.gif),
//         ),
//       ),
//     );
//   }
// }

class ShowGIF extends StatelessWidget {
  final String gif;

  ShowGIF(this.gif);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: ClipRRect(
        child: Image.asset(gif),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
