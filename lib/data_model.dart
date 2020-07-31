class Reminder {
  String name;
  List<ReminderDetail> reminder;

  Reminder({this.name, this.reminder});

  Reminder.fromJSON(Map json) {
    name = json['name'];
    var list = json['reminder'] as List;
    reminder = list.map((e) => ReminderDetail.fromJSON(e)).toList();
  }

  Map toJson() {
    return {'name': name, 'reminder': reminder};
  }
}

class ReminderDetail {
  String medicine;
  String dosage;
  String time;
  String status;
  String type;

  ReminderDetail(
      {this.medicine, this.dosage, this.time, this.status, this.type});

  ReminderDetail.fromJSON(Map json)
      : medicine = json['medicine'],
        dosage = json['dosage'],
        time = json['time'],
        status = json['status'],
        type = json['type'];

  Map toJson() {
    return {
      'medicine': medicine,
      'dosage': dosage,
      'time': time,
      'status': status,
      'type': type
    };
  }
}
