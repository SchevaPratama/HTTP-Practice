import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HttpProvider with ChangeNotifier {
  Map<String, dynamic> _data = {};

  Map<String, dynamic> get data => _data;

  int get jumlahData => _data.length;

  Uri? url;

  void connectAPI(BuildContext context, String id) async {
    url = Uri.parse("https://reqres.in/api/users/" + id);

    var hasilResponse = await http.get(url!);

    if (hasilResponse.statusCode == 200) {
      _data = (json.decode(hasilResponse.body))["data"];
      notifyListeners();
      ingpoSnackbar(context, 'Berhasil Get Data');
    } else {
      ingpoSnackbar(context, 'Gagal Get Data');
    }
  }

  void deleteData(BuildContext context) async {
    var hasilResponse = await http.delete(url!);

    if (hasilResponse.statusCode == 204) {
      _data = {};
      notifyListeners();
      ingpoSnackbar(context, 'Data berhasil dihapus');
    }
  }

  ingpoSnackbar(BuildContext context, String inpo) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(inpo),
        duration: Duration(milliseconds: 700),
      ),
    );
  }
}
