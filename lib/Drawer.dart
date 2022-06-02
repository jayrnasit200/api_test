import 'package:flutter/material.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String? stringResponse;
Map? mapResponse;
Map? dataResponse;

class Drawers extends StatefulWidget {
  @override
  State<Drawers> createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse('https://reqres.in/api/users/2'));
    if (response.statusCode == 200) {
      setState(() {
        // stringResponse = response.body;
        mapResponse = json.decode(response.body);
        dataResponse = mapResponse!['data'];
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(children: [
          dataResponse != null
              ? UserAccountsDrawerHeader(
                  currentAccountPicture:
                      Image.network(dataResponse!['avatar'].toString()),
                  accountName: Text(dataResponse!['first_name'].toString() +
                      ' ' +
                      dataResponse!['last_name'].toString()),
                  accountEmail: Text(dataResponse!['email'].toString()),
                )
              : Text('data'),
          ListTile(title: Text('data is lodding')),
        ]),
      ),
    );
  }
}
