import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_party_planner/Models/guest.dart';
import 'package:lazy_party_planner/Models/party.dart';
import 'package:random_color/random_color.dart';

class PartySingleton {
  static final PartySingleton _singleton = PartySingleton._internal();
  List<Party> arrParties = [];

  factory PartySingleton() { // factory method help with singleton pattern
    return _singleton;
  }

  PartySingleton._internal(){ // initializer function calls only the first time initialized
    // dumy data
    RandomColor _randomColor = RandomColor();

    if(arrParties.isEmpty){
      Color _color = _randomColor.randomColor();
      arrParties.add(Party(sID: UniqueKey().toString(), sPartyName: "Nghia Birthday", sDate: "Oct 04, 2021", sTime: "12:00 PM", arrGuests: [GuestInfo(sID: UniqueKey().toString(), sFirstName: 'Hieu', sLastName: 'Nguyen'), GuestInfo(sID: UniqueKey().toString(), sFirstName: 'Trung', sLastName: 'Nguyen')], colorID: _color));

      _color = _randomColor.randomColor();
      arrParties.add(Party(sID: UniqueKey().toString(),sPartyName: "Hieu Birthday", sDate: "Oct 04, 2021", sTime: "12:00 PM", arrGuests: [GuestInfo(sID: UniqueKey().toString(), sFirstName: 'Nghia', sLastName: 'Nguyen'), GuestInfo(sID: UniqueKey().toString(), sFirstName: 'Trung', sLastName: 'Nguyen')], colorID: _color));

      // _color = _randomColor.randomColor();
      // arrParties.add(Party(sID: UniqueKey().toString(),sPartyName: "Trung Birthday", sDate: "Oct 04, 2021", sTime:  "12:00 PM", arrGuests:  [GuestInfo(sID: UniqueKey().toString(), sFirstName: 'Hieu', sLastName: 'Nguyen'), GuestInfo(sID: UniqueKey().toString(), sFirstName: 'Nghia', sLastName: 'Nguyen')], colorID: _color));
      //
      // _color = _randomColor.randomColor();
      // arrParties.add(Party(sID: UniqueKey().toString(),sPartyName: "Hong Birthday", sDate: "Oct 04, 2021", sTime:  "12:00 PM", arrGuests: [GuestInfo(sID: UniqueKey().toString(), sFirstName: 'Duc', sLastName: 'Nguyen'), GuestInfo(sID: UniqueKey().toString(), sFirstName: 'Trung', sLastName: 'Nguyen')], colorID: _color));
      //
      // _color = _randomColor.randomColor();
      // arrParties.add(Party(sID:  UniqueKey().toString(),sPartyName: "Duc Birthday", sDate: "Oct 04, 2021", sTime:  "12:00 PM", arrGuests: [GuestInfo(sID: UniqueKey().toString(), sFirstName: 'Trung', sLastName: 'Nguyen'), GuestInfo(sID: UniqueKey().toString(), sFirstName: 'Hieu', sLastName: 'Nguyen')], colorID: _color));

    }
  }

  List<Party> get partyList {
    return arrParties;
  }

  // add party function
  void createParty(Party newParty){
    arrParties.add(newParty);
  }

  // modify party function
  void updateParty(Party party){
    int index = arrParties.indexOf(party);
    arrParties[index].sPartyName = party.sPartyName;
    arrParties[index].sDate = party.sDate;
    arrParties[index].sTime = party.sTime;
    arrParties[index].arrGuests = party.arrGuests;
  }

  // delete party function
  void deleteParty(Party party){
    arrParties.removeWhere((element) => element.sID == party.sID);
  }

  // add guest function
  void addGuest(Party party, GuestInfo newGuest){
    int index = arrParties.indexOf(party);
    if(arrParties[index].arrGuests == null){
      arrParties[index].arrGuests = <GuestInfo>[];
      arrParties[index].arrGuests!.add(newGuest);
    } else {
      arrParties[index].arrGuests!.add(newGuest);
    }

  }

  // remove guest of a party function
  void removeGuest(Party party, GuestInfo guest){
    int index = arrParties.indexOf(party);
    arrParties[index].arrGuests!.remove(guest);
  }

  // get guest info of a party
  List<GuestInfo> guestList(Party party){
    int index = arrParties.indexOf(party);
    return arrParties[index].arrGuests!.toList();
  }

  // edit guest info
  void editGuestInfo(Party party, GuestInfo guest){
    int index = arrParties.indexOf(party);
    if(arrParties[index].arrGuests != null && arrParties[index].arrGuests!.isNotEmpty){
      int indexGuest = arrParties[index].arrGuests!.indexOf(guest);
      GuestInfo editGuess = arrParties[index].arrGuests![indexGuest];
      editGuess.sFirstName = guest.sFirstName;
      editGuess.sLastName = guest.sLastName;
      editGuess.sEmail = guest.sEmail != null && guest.sEmail!.isNotEmpty ? '' : guest.sEmail;
    }

  }
}