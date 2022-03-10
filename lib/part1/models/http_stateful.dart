import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpStateful {
  String? id, name, job, createdAt = '';

  HttpStateful({
    this.id,
    this.name,
    this.job,
    this.createdAt,
  });

  static Future<HttpStateful> connectAPI(String name, String job) async {
    Uri url = Uri.parse('https://reqres.in/api/users');

    var responseResult = await http.post(
      url,
      body: {
        "name": name,
        "job": job,
      },
    );

    var data = json.decode(responseResult.body);
    return HttpStateful(
      id: data['id'],
      name: data['name'],
      job: data['job'],
      createdAt: data['createdAt'],
    );
  }
}
