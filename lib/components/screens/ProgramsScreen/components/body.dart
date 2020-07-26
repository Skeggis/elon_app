import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:myapp/services/models/DeviceModel.dart';

class ProgramsScreenBody extends StatefulWidget {

@override
  State<StatefulWidget> createState() {
    return _ProgramsScreenBodyState();
  }
}

class _ProgramsScreenBodyState extends State<ProgramsScreenBody>{

  Future<Map> items;

  void initState(){
    super.initState();
  }

  Future test() async {
    var response = await http.get('https://elon-server.herokuapp.com/programs');
    print('her');
    print(response.body);
    var data = await json.decode(response.body);

    print(data);
    return data;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: test(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            child: Text('done'),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
