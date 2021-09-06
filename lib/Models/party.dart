import 'dart:ui';

import 'package:flutter/material.dart';

import 'guest.dart';

class Party{
  String? sID;
  String? sPartyName;
  String? sDate;
  String? sTime;
  List<GuestInfo>? arrGuests = [];
  Color? colorID;

  Party({required this.sID, required this.sPartyName, required this.sDate, this.sTime, this.arrGuests , required this.colorID});

  Party.newEmptyParty();

  get partyName => sPartyName.toString();

}
