import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpProvider extends ChangeNotifier {
  Map<String, dynamic> _data = {};
  Map<String, dynamic> get data => _data;

  int get jumlahData => _data.length;

  void connectAPI(String name, String job) async {
    Uri url = Uri.parse('https://reqres.in/api/users');

    var responseResult = await http.post(
      url,
      body: {
        "name": name,
        "job": job,
      },
    );

    _data = json.decode(responseResult.body);
    notifyListeners();
  }
}
