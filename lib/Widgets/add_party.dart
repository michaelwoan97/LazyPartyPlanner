// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lazy_party_planner/Models/party.dart';
import 'package:lazy_party_planner/Widgets/form_party.dart';
import 'package:lazy_party_planner/party_signleton.dart';
import 'package:random_color/random_color.dart';

import 'edit_party.dart';

class AddParty extends StatefulWidget {
  int iCode;
  Party party;
  AddParty({Key? key, required this.iCode, required this.party }) : super(key: key);

  @override
  _AddPartyState createState() => _AddPartyState();
}

class _AddPartyState extends State<AddParty> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var newEmptyParty = Party.newEmptyParty();
    final formParty = FormParty(formKey: _formKey, partyInfo: newEmptyParty, iFormCode: 0,);

    return Scaffold(
      backgroundColor: const Color(0xFFE9EBEE),
      appBar: AppBar(
        title: Text("LazyPartyPlanner"),
        actions: [
          IconButton(
            icon: Icon(Icons.cleaning_services_rounded),
            color: Colors.white,
            onPressed: () =>{},
          )
        ],
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.48,
          child: Card(
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 8, ),
              child: widget.iCode == 0 ? Column(
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
                                  // check whether there is time
                                  String timeParty = formParty.sTime.isNotEmpty ? formParty.sTime : "";

                                  // create new party then add to the list
                                  RandomColor _randomColor = RandomColor();
                                  Color _color = _randomColor.randomColor();
                                  Party newParty = Party(sID: UniqueKey().toString(),sPartyName: formParty.sParty, sDate: formParty.sDate, sTime: formParty.sTime, arrGuests: formParty.arrGuests, colorID: _color);
                                  PartySingleton singleton = PartySingleton();
                                  setState(() {
                                    singleton.createParty(newParty);
                                  });
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.add),
                                  const Text('Add Party')
                                ],
                              )),
                        ],
                      )),
                ],
              ) : EditParty(party: widget.party),
            ),
          ),
        ),
      ),
    );
  }



}
