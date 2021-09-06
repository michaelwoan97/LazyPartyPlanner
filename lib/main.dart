import 'package:flutter/material.dart';
import 'package:lazy_party_planner/Widgets/add_party.dart';
import 'package:lazy_party_planner/Widgets/party_list.dart';
import 'package:lazy_party_planner/party_signleton.dart';
import './Models/party.dart';

// the current trouble adding new party
void main() {
  // ignore: prefer_const_constructors
  runApp(MaterialApp(
    title: 'LazyPartyPlanner',
    theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: "Merriweather",
        appBarTheme: AppBarTheme(
            textTheme: ThemeData
                .light()
                .textTheme
                .copyWith(
                title: const TextStyle(
                    fontFamily: "KaiseiDecol",
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                )
            )
        )
    ),
    // ignore: prefer_const_constructors
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{



  @override
  Widget build(BuildContext context) {
    PartySingleton singleton = PartySingleton();
    List<Party> parties = singleton.partyList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('LazyPartyPlanner'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddParty(iCode: 0, party: Party.newEmptyParty()))
              ).then((_) => setState(() {}));
            },
          )
        ],
      ),
      backgroundColor: const Color(0xFFE9EBEE),
      body: parties.isEmpty
          ? const Center(
        child: Text("There is no parties!"),
      )
      // ignore: prefer_const_constructors
          : PartyList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddParty(iCode: 0, party: Party.newEmptyParty()))
          ).then((_) => setState(() {}));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}



