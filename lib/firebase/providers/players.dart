import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/player.dart';

class Players with ChangeNotifier {
  List<Player> _allPlayer = [];

  List<Player> get allPlayer => _allPlayer;

  int get jumlahPlayer => _allPlayer.length;

  Player selectById(String id) =>
      _allPlayer.firstWhere((element) => element.id == id);

  addPlayer(String name, String position, String image) async {
    DateTime datetimeNow = DateTime.now();

    Uri url = Uri.parse(
        'https://http-req-8d682-default-rtdb.firebaseio.com/players.json');

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'name': name,
            'position': position,
            'imageUrl': image,
            'createdAt': datetimeNow.toString(),
          },
        ),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _allPlayer.add(
          Player(
            id: jsonDecode(response.body)['name'].toString(),
            name: name,
            position: position,
            imageUrl: image,
            createdAt: datetimeNow,
          ),
        );
        notifyListeners();
      } else {
        throw ("${response.statusCode}");
      }
    } catch (e) {
      throw (e);
    }
  }

  editPlayer(
      String id, String name, String position, String image) async {
    Uri url = Uri.parse(
        'https://http-req-8d682-default-rtdb.firebaseio.com/players/${id}.json');

    try {
      final response = await http.patch(
        url,
        body: json.encode(
          {
            'name': name,
            'position': position,
            'imageUrl': image,
          },
        ),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Player selectPlayer =
            _allPlayer.firstWhere((element) => element.id == id);
        selectPlayer.name = name;
        selectPlayer.position = position;
        selectPlayer.imageUrl = image;
        notifyListeners();
      } else {
        throw ("${response.statusCode}");
      }
    } catch (e) {
      throw (e);
    }
  }

  deletePlayer(String id) async{
    Uri url = Uri.parse(
        'https://http-req-8d682-default-rtdb.firebaseio.com/players/${id}.json');

    try {
      final response = await http.delete(url).then((response) {
      _allPlayer.removeWhere((element) => element.id == id);
      notifyListeners();
    });
      if (response.statusCode < 200 && response.statusCode > 300) {
        throw ("${response.statusCode}");
      }
    } catch (e) {
      throw (e);
    }
  }

  Future initialData() async {
    Uri url = Uri.parse(
        'https://http-req-8d682-default-rtdb.firebaseio.com/players.json');

    var hasilGet = await http.get(url);
    print(jsonDecode(hasilGet.body));

    if (jsonDecode(hasilGet.body) == null) {
      print(hasilGet.body);
    } else {
      var dataResponse = (json.decode(hasilGet.body) as Map<String, dynamic>);

      dataResponse.forEach(
        (key, value) {
          DateTime dateTImeParse =
              DateFormat("yyyy-mm-dd hh:mm:ss").parse(value['createdAt']);
          _allPlayer.add(
            Player(
              id: key,
              createdAt: dateTImeParse,
              imageUrl: value["imageUrl"],
              name: value["name"],
              position: value["position"],
            ),
          );
        },
      );
      notifyListeners();
    }
  }
}
