import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models/maptolistapicallModel.dart';

void main() => runApp(ApiCallUsingMaptoList());

class ApiCallUsingMaptoList extends StatefulWidget {
  const ApiCallUsingMaptoList({Key? key}) : super(key: key);

  @override
  State<ApiCallUsingMaptoList> createState() => _ApiCallUsingMaptoListState();
}

class _ApiCallUsingMaptoListState extends State<ApiCallUsingMaptoList> {
  List<MaptolistapicallModel>? apiList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getApidata();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Map to list api caliing'),
        ),
        body: Column(
          children: [getList()],
        ),
      ),
    );
  }

  Widget getList() {
    return Expanded(
      child: ListView.builder(
        itemCount: apiList!.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 4, 10),
                  width: double.infinity,
                  child: Text('Email:  ${apiList![index].email}'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  getApidata() async {
    String url = 'https://jsonplaceholder.typicode.com/comments';

    var response = await http.get(Uri.parse(url));

    //if api data is in form of object not in list then here we only map to data to fromjson not neede toList() and cast ,ethod.
    apiList = jsonDecode(response.body)
        .map((item) => MaptolistapicallModel.fromJson(item))
        .toList()
        .cast<MaptolistapicallModel>();
  }
}
