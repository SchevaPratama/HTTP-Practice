import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpStateful {
  String? id, fullname, email, avatar = '';

  HttpStateful({
    this.id,
    this.fullname,
    this.email,
    this.avatar,
  });

  static Future<HttpStateful> connectAPI(String id) async {
    Uri url = Uri.parse('https://reqres.in/api/users/' + id);

    var dataResponse = await http.get(url);
    var data = (json.decode(dataResponse.body))['data'];

    print(data);
    return HttpStateful(
      id: data['id'].toString(),
      fullname: data['first_name'] + ' ' + data['last_name'],
      email: data['email'],
      avatar: data['avatar'],
    );
  }
}
