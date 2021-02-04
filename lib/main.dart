import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JsonHttp(),
    ));

class JsonHttp extends StatefulWidget {
  @override
  _JsonHttpState createState() => _JsonHttpState();
}

class _JsonHttpState extends State<JsonHttp> {
  final String url = "https://jsonplaceholder.typicode.com/posts";
  List data;

  @override
  void initState() {
    
    super.initState();
    this.jsonData();
  }

  Future<String> jsonData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    print(response);

    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson;
    });

    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('JSON APP FROM API'),
        ),
        body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                  Card(child: Container(child: Text(data[index]["body"],
                  ),
                  padding: EdgeInsets.all(20.0),))
                ])));
          },
        ));
  }
}
