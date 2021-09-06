import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lazy_party_planner/Models/guest.dart';
import 'package:lazy_party_planner/Models/party.dart';
import 'package:lazy_party_planner/Widgets/add_guests.dart';
import 'package:lazy_party_planner/Widgets/edit_guests.dart';

import '../party_signleton.dart';

class FormParty extends StatefulWidget {
  late GlobalKey<FormState> formKey;
  int iFormCode;
  late Party partyInfo;

  late String sParty;
  late String sDate;
  late String sTime;
  List<GuestInfo> arrGuests = [];

  FormParty(
      {Key? key,
      required this.formKey,
      required this.partyInfo,
      required this.iFormCode})
      : super(key: key);

  @override
  _FormPartyState createState() => _FormPartyState();
}

class _FormPartyState extends State<FormParty> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _partyController = TextEditingController();
  final DateTime _firstDate = DateTime(2021);
  final DateTime _lastDate = DateTime(2222);
  final _dateFormat = DateFormat("EEE, MMM d, yyyy");
  bool bUsedInitialValue = false;
  bool bCreatedNewParty = false;
  late int retCode = 0;

  late List<GuestInfo> _guests = [];

  @override
  Widget build(BuildContext context) {
    // check whether it is creating new party or not
    if (widget.iFormCode == 1 && !bUsedInitialValue) {
      // assign initial values if edit a party
      _partyController.text = widget.partyInfo.sPartyName.toString();
      _dateController.text = widget.partyInfo.sDate.toString();
      _timeController.text = widget.partyInfo.sTime.toString();
      _guests = widget.partyInfo.arrGuests!.toList();
      bUsedInitialValue = true;
    } else if (widget.iFormCode == 0 && !bCreatedNewParty) {
      widget.partyInfo = Party.newEmptyParty();
      bCreatedNewParty = true;
    }

    // save the value of controller if the screen is re-render
    widget.sParty =
        _partyController.text.isNotEmpty ? _partyController.text : '';
    widget.sDate = _dateController.text.isNotEmpty ? _dateController.text : '';
    widget.sTime = _timeController.text.isNotEmpty ? _timeController.text : '';
    widget.arrGuests = _guests.isNotEmpty? _guests : [];

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _partyController,
            onFieldSubmitted: (sParty) {
              widget.sParty = sParty;
            },
            onChanged: (sParty) {
              widget.sParty = sParty;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.celebration),
              labelText: 'Party Name',
            ),
            validator: (text) {
              if (text == null || text.isEmpty) {
                return "Please, enter a name!";
              }
              return null;
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Container(
                  child: Expanded(
                    flex: 6,
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: TextFormField(
                        controller: _dateController,
                        onFieldSubmitted: (sDate) {
                          widget.sDate = sDate;
                        },
                        onChanged: (sDate) {
                          widget.sDate = sDate;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.date_range),
                          labelText: 'Date',
                        ),
                        onTap: () => {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: _firstDate,
                                  lastDate: _lastDate)
                              .then((datePicked) {
                            if (datePicked != null) {
                              updateTextController(_dateController, datePicked);
                            }
                          })
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Please, enter a date!";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                      controller: _timeController,
                      onFieldSubmitted: (sTime) {
                        widget.sTime = sTime;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.watch_later_outlined),
                        labelText: 'Time',
                      ),
                      onTap: () => {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((timePicked) {
                              if (timePicked != null) {
                                setState(() {
                                  _timeController.text =
                                      timePicked.format(context).toString();
                                });
                              }
                            })
                          }),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Theme.of(context).primaryColor,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) {
                                    if(widget.iFormCode == 0){
                                      return AddGuests(guests: [...widget.arrGuests],);
                                    } else {
                                      return EditGuests(guests: [...widget.partyInfo.arrGuests!.toList()],);
                                    }
                                  }))
                          .then((value) {
                        setState(() {
                          // value: GuestInfo
                          if(value != null) {
                            _guests = value;
                            print(_guests.length);
                          }

                          // _guests = value[1] != null ? value[1] as List<GuestInfo> : [];
                          // retCode = value[0];
                          // if(widget.iFormCode == 1){
                          //   PartySingleton().updateParty(widget.partyInfo);
                          // } else {
                          //
                          // }
                        });
                      });
                    },
                    leading: const Icon(
                      Icons.people,
                      color: Colors.white,
                    ),
                    title: Text(
                      "${_guests.length} ${_guests.length > 1 ? 'Guests' : 'Guest'}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'KaiseiDecol',
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateTextController(
      TextEditingController controller, DateTime datePicked) {
    setState(() {
      controller.text = _dateFormat.format(datePicked);
    });
  }
}
