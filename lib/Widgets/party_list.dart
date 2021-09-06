import 'package:flutter/material.dart';
import 'package:lazy_party_planner/Models/party.dart';
import 'package:lazy_party_planner/Widgets/edit_party.dart';
import 'package:lazy_party_planner/party_signleton.dart';
import 'package:random_color/random_color.dart';

import 'add_party.dart';

class PartyList extends StatefulWidget {
  const PartyList({Key? key}) : super(key: key);

  @override
  _PartyListState createState() => _PartyListState();
}

class _PartyListState extends State<PartyList> {
  void removeParty(Party party) {
    PartySingleton singleton = PartySingleton();
    setState(() {
      singleton.deleteParty(party);
    });
  }

  @override
  Widget build(BuildContext context) {
    PartySingleton singleton = PartySingleton();
    List<Party> parties = singleton.partyList;

    if (parties.isEmpty) {
      return const Center(
        child: Text("There is no parties!"),
      );
    } else {
      return ListView.builder(
        itemCount: parties.length,
        itemBuilder: (ctx, index) {
          Party party = parties[index];
          return Card(
            child: ListTile(
                onTap: () {
                  Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => AddParty(iCode: 1, party: party)))
                      .then((_) {
                    setState(() {});
                  });
                },
                leading: Container(
                  width: 10,
                  color: party.colorID,
                ),
                title: Text(party.sPartyName.toString()),
                subtitle: Text(party.sDate.toString()),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_outlined,
                    color: Colors.red,
                  ),
                  onPressed: () => removeParty(party),
                )),
          );
        },
      );
    }
  }
}
