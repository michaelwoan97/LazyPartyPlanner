import 'package:flutter/material.dart';
import 'package:lazy_party_planner/Models/guest.dart';

enum GuestStat {
  cancel,
  add,
  edit
}


class AddGuests extends StatefulWidget {
  List<GuestInfo>? guests;
  AddGuests({Key? key, this.guests}) : super(key: key);

  @override
  _AddGuestsState createState() => _AddGuestsState();
}

class _AddGuestsState extends State<AddGuests> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  late List<GuestInfo> _guests = [];
  late bool bUsedInitialValue = false;

  @override
  Widget build(BuildContext context) {
    if(widget.guests!.isNotEmpty && !bUsedInitialValue){
      _guests = widget.guests!.toList();
      bUsedInitialValue = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("LazyPartyPlanner"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            color: Colors.white,
            onPressed: () => {Navigator.of(context).pop(_guests)},
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
              child: const Text(
                'Guests',
                style: TextStyle(fontSize: 18),
              )),
          if (_guests.isNotEmpty)
            Expanded(
              child: ListView(
                children: [
                  ..._guests.map((e) {
                    String sGuestFirstName = e.sFirstName.toString();
                    String sGuestLastName = e.sLastName.toString();
                    return Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 0.5, color: Colors.black),
                          bottom: BorderSide(width: 0.5, color: Colors.black),
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          editGuestDialog(e);
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 30,
                          child: CircleAvatar(
                            backgroundColor: const Color(0xffC0C0C0),
                            radius: 27,
                            child: Text(
                              "${sGuestFirstName[0].toUpperCase()}${sGuestLastName[0].toUpperCase()} ",
                              style: const TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        title: Text("$sGuestFirstName $sGuestLastName"),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.red,
                          ),
                          onPressed: () {

                            // delete function
                            setState(() {
                              _guests.remove(e);
                            });
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            )
          else
            const Center(child: Text('There is no guests!')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          addGuestDialog();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> addGuestDialog() async {
    switch (await showDialog<GuestStat>(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            title: const Text('New Guest Info'),
            children: [
              Container(
                margin: const EdgeInsets.only(left: 24, right: 24),
                child: Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration:
                                const InputDecoration(labelText: 'First Name'),
                            validator: (firstName) {
                              if (firstName == null || firstName.isEmpty) {
                                return '*required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 8),
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration:
                                const InputDecoration(labelText: 'Last Name'),
                            validator: (lastName) {
                              if (lastName == null || lastName.isEmpty) {
                                return '*required';
                              }
                              return null;
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 24, right: 24),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email Address'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 28, right: 24),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          Navigator.pop(ctx, GuestStat.cancel);
                        },
                        child: const Text('Cancel')),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              GuestInfo newGuest = GuestInfo(
                                  sID: UniqueKey().toString(),
                                  sLastName: _lastNameController.text,
                                  sFirstName: _firstNameController.text,
                              sEmail: _emailController.text);

                              _guests.add(newGuest);
                              _firstNameController.text = '';
                              _lastNameController.text = '';
                            });
                            Navigator.pop(ctx, GuestStat.add);
                          }
                        },
                        child: const Text('Add'))
                  ],
                ),
              )
            ],
          );
        })) {
      case GuestStat.cancel:
        print('cancel add guest');
        break;
      case GuestStat.edit:
        print('edit guest');
        break;
      case GuestStat.add:
        print('added guestsssss!');
        break;
      case null:
        break;
    }
  }
  Future<void> editGuestDialog(GuestInfo guest) async{
    switch(await showDialog<GuestStat>(
        context: context,
        builder: (ctx) {
          _firstNameController.text = guest.sFirstName.toString();
          _lastNameController.text = guest.sLastName.toString();
          _emailController.text = guest.sEmail!.isNotEmpty ? guest.sEmail.toString() : '';
          return SimpleDialog(
            title: const Text('Edit Guest Info'),
            children: [
              Container(
                margin: const EdgeInsets.only(left: 24,right: 24),
                child: Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                                labelText: 'First Name'
                            ),
                            validator: (firstName) {
                              if(firstName == null || firstName.isEmpty){
                                return '*required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 8),
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                                labelText: 'Last Name'
                            ),
                            validator: (lastName) {
                              if(lastName == null || lastName.isEmpty){
                                return '*required';
                              }
                              return null;
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 24,right: 24),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email Address'
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 28, right: 24),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(onPressed: () {
                      Navigator.pop(ctx, GuestStat.cancel);
                    }, child: const Text('Cancel')),
                    ElevatedButton(onPressed: () {
                      if (_formKey.currentState!.validate()){
                        setState(() {
                          guest.sFirstName = _firstNameController.text;
                          guest.sLastName = _lastNameController.text;
                          guest.sEmail = _emailController.text.isNotEmpty ? _emailController.text : '';

                          // this is good for only edit guess situation
                          int index = _guests.indexOf(guest);
                          _guests[index].sFirstName = guest.sFirstName;
                          _guests[index].sLastName = guest.sLastName;
                          _guests[index].sEmail = guest.sEmail;

                          _firstNameController.text = '';
                          _lastNameController.text = '';
                        });
                        Navigator.pop(ctx, GuestStat.add);
                      }
                    }, child: const Text ('Edit'))
                  ],
                ),
              )
            ],
          );
        })){
      case GuestStat.cancel:
        print('cancel add guest');
        break;
      case GuestStat.edit:
        print('edit guest');
        break;
      case GuestStat.add:
        print('added guestsssss!');
        break;
      case null:
        break;
    }
  }
}
