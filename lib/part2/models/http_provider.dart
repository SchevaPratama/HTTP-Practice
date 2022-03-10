import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HttpProvider extends ChangeNotifier {
  Map<String, dynamic> _data = {};
  Map<String, dynamic> get data => _data;

  int get jumlahData => _data.length;

  void connectAPI(String id) async {
    Uri url = Uri.parse('https://reqres.in/api/users/' + id);

    var dataResponse = await http.get(url);
    _data = (json.decode(dataResponse.body))['data'];
    print(data);
    notifyListeners();
  }
}
