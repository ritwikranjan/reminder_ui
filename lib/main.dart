import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          title: Text('Reminder'),
        ),
        body: Column(
          children: <Widget>[
            ReminderBox(),
            ReminderBox(),
          ],
        ),
      ),
    );
  }
}

class ReminderBox extends StatefulWidget {
  @override
  _ReminderBoxState createState() => _ReminderBoxState();
}

class _ReminderBoxState extends State<ReminderBox> {
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          border: Border.all(width: 2.0, color: Colors.blueGrey[100]),
        ),
        child: ListView.builder(
            itemCount: 4,
            itemBuilder: (_, index) {
              if (index == 0) {
                return Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  color: Colors.blueGrey[100],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Reminder by Doctor',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.blueGrey[900],
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 5.0),
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(25.0),
                              color:
                                  (index % 2 == 0) ? Colors.blue : Colors.red,
                              child: Icon(Icons.healing)),
                          Container(
                            margin: EdgeInsets.only(left: 10.0, top: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Medicine Name'),
                                    SizedBox(
                                      width: 120,
                                    ),
                                    Text('Time'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Dosage'),
                                    SizedBox(
                                      width: 145,
                                    ),
                                    Switch(
                                      activeColor: Colors.red,
                                      value: isSwitched,
                                      onChanged: (value) {
                                        setState(() {
                                          isSwitched = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                );
              }
            }),
      ),
    );
  }
}
