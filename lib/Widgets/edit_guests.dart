import 'package:flutter/material.dart';
import 'package:lazy_party_planner/Models/guest.dart';
import 'package:lazy_party_planner/Widgets/add_guests.dart';

class EditGuests extends StatefulWidget {
  List<GuestInfo> guests;

  EditGuests({Key? key, required this.guests}) : super(key: key);

  @override
  _EditGuestsState createState() => _EditGuestsState();
}

class _EditGuestsState extends State<EditGuests> {
  @override
  Widget build(BuildContext context) {
    return AddGuests(guests: [...widget.guests],);
  }
}
