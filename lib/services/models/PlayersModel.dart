import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

import 'package:myapp/services/models/Player.dart';

import 'package:myapp/services/models/Organization.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlayersModel extends Model {
  List<Player> _allPlayers = [];
  Future fetchAllPlayers() async {
    // try {
    //   var response =
    //       await http.get('https://elon-server.herokuapp.com/players');
    //   if (response.statusCode == 200) {
    //     var jsonPrograms = convert.jsonDecode(response.body)['players'] as List;
    //     _allPlayers =
    //         jsonPrograms.map((program) => Player.fromJson(program)).toList();
    //     notifyListeners();
    //   }
    // } catch (e) {
    //   print('error fetching programs');
    //   print(e);
    // }
    _allPlayers = [
      new Player(
        name: 'Þórður Ágústsson',
        organization: new Organization(
          name: 'Badmintonfélag Hafnarfjarðar',
        ),
      ),
      new Player(
        name: 'Róbert Ingi Huldarsson',
        organization: new Organization(
          name: 'Badmintonfélag Hafnarfjarðar',
        ),
      ),
      new Player(
        name: 'Þórður Ágústsson',
        organization: new Organization(
          name: 'Badmintonfélag Hafnarfjarðar',
        ),
      ),
      new Player(
        name: 'Róbert Ingi Huldarsson',
        organization: new Organization(
          name: 'Badmintonfélag Hafnarfjarðar',
        ),
      ),
      new Player(
        name: 'Þórður Ágústsson',
        organization: new Organization(
          name: 'Badmintonfélag Hafnarfjarðar',
        ),
      ),
      new Player(
        name: 'Róbert Ingi Huldarsson',
        organization: new Organization(
          name: 'Badmintonfélag Hafnarfjarðar',
        ),
      )
    ];
    newSearch(_searchText);
    return _allPlayers;
  }

  List<Player> _playersInSearch = [];

  List<Player> get playersInSearch => _playersInSearch;

  String _searchText = '';

  void newSearch(String text) {
    if (text == '' || text == null) {
      _playersInSearch = _allPlayers;
    } else {
      _playersInSearch = _allPlayers
          .where((player) =>
              player.name != null &&
              player.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
    _searchText = text;
    notifyListeners();
  }

  static PlayersModel of(BuildContext context,
          {bool rebuildOnChange = false}) =>
      ScopedModel.of<PlayersModel>(context,
          rebuildOnChange: rebuildOnChange == null ? false : rebuildOnChange);
}
