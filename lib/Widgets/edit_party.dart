// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lazy_party_planner/Models/party.dart';
import 'package:lazy_party_planner/Widgets/form_party.dart';
import 'package:random_color/random_color.dart';

import '../party_signleton.dart';

class EditParty extends StatefulWidget {
  Party party;
  EditParty({Key? key, required this.party}) : super(key: key);

  @override
  _EditPartyState createState() => _EditPartyState();
}

class _EditPartyState extends State<EditParty> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final formParty = FormParty(formKey: _formKey, partyInfo: widget.party, iFormCode: 1,);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          formParty,
          Container(
              margin: EdgeInsets.only(top: 16),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

                          // new info
                          String sNewPartyName = formParty.sParty.toString();
                          String sNewPartyDate = formParty.sDate.toString();
                          String sNewPartyTime = formParty.sTime.toString();

                          // update info
                          widget.party.sPartyName = sNewPartyName;
                          widget.party.sDate = sNewPartyDate;
                          widget.party.sTime = sNewPartyTime;
                          widget.party.arrGuests = formParty.arrGuests.toList();
                          PartySingleton singleton = PartySingleton();
                          Navigator.of(context).pop();
                        }
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.edit),
                          Text('Edit Party')
                        ],
                      )),
                ],
              )),
        ],
      );
  }
}
