import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './firebase/providers/players.dart';
import './firebase/pages/detail_player.dart';
import './firebase/pages/add_player.dart';
import './firebase/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Players(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: {
          AddPlayer.routeName: (context) => AddPlayer(),
          DetailPlayer.routeName: (context) => DetailPlayer(),
        },
      ),
    );
  }
}