import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:reminder_ui/data_model.dart';
import 'package:reminder_ui/networking.dart';

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
        body: CustomBox(),
      ),
    );
  }
}

class CustomBox extends StatefulWidget {
  @override
  _CustomBoxState createState() => _CustomBoxState();
}

class _CustomBoxState extends State<CustomBox> {
  List<Reminder> reminderList;

  NetworkHelper networkHelper = NetworkHelper(
      url: 'https://run.mocky.io/v3/ce664969-a478-432b-a724-f5695a29a4c3');

  getData() {
    networkHelper.fetchData().then((value) {
      setState(() {
        reminderList = value;
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (reminderList == null) {
      return Center(
        child: Icon(
          Icons.cloud_download,
          size: 50.0,
        ),
      );
    } else {
      return ListView.builder(
        itemCount: reminderList.length,
        itemBuilder: (_, index) {
          return Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
              border: Border.all(width: 2.0, color: Colors.blueGrey[100]),
            ),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: (reminderList[index].reminder.length + 1),
                itemBuilder: (_, subIndex) {
                  if (subIndex == 0) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      color: Colors.blueGrey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Reminder by ${reminderList[index].name}',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blueGrey[900],
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  } else {
                    ReminderDetail reminder =
                        reminderList[index].reminder[subIndex - 1];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0),
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                    padding: EdgeInsets.all(25.0),
                                    color: (subIndex % 2 == 0)
                                        ? Colors.blue
                                        : Colors.red,
                                    child: Icon(Icons.healing)),
                              ),
                              Expanded(
                                flex: 7,
                                child: Container(
                                  margin:
                                      EdgeInsets.only(left: 10.0, top: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('${reminder.medicine}'),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 6.0),
                                            child: Text('${reminder.time}'),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                              '${reminder.dosage} ${reminder.type}'),
                                          Switch(
                                            activeColor: Colors.red,
                                            value:
                                                reminder.status.contains('on'),
                                            onChanged: (value) {
                                              setState(() {
                                                if (!value) {
                                                  reminder.status = 'off';
                                                } else {
                                                  reminder.status = 'on';
                                                }
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                    );
                  }
                }),
          );
        },
      );
    }
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
    return Container(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(25.0),
                            color: (index % 2 == 0) ? Colors.blue : Colors.red,
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
    );
  }
}
