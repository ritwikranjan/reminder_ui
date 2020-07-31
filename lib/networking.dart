import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reminder_ui/data_model.dart';

class NetworkHelper {
  String url;
  NetworkHelper({this.url});

  Future<List<Reminder>> fetchData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var list = json.decode(response.body) as List;
      return list.map((e) => Reminder.fromJSON(e)).toList();
    } else
      throw response.statusCode;
  }
}
