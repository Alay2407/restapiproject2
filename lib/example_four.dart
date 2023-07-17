import 'dart:convert';

import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;

class ExampleFour extends StatefulWidget {
  const ExampleFour({Key? key}) : super(key: key);

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {
  //here we store data in varible data not in list.
  //we coudn't create model class in this example
  var data;
  Future<void> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {
      Text("Waiting for data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example Four'),
      ),
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
            future: getUserApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading');
              }
              else {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: Column(
                      children: [
                        RowData(
                          title: 'Id',
                          value: data[index]['id'].toString(),
                        ),
                        RowData(
                          title: 'Name',
                          value: data[index]['name'].toString(),
                        ),
                        RowData(
                          title: 'User Name',
                          value: data[index]['username'].toString(),
                        ),
                        RowData(
                          title: 'Email',
                          value: data[index]['email'].toString(),
                        ),
                        RowData(
                          title: 'City',
                          value: data[index]['address']['city'].toString(),
                        ),
                      ],
                    ));
                  },
                );
              }
            },
          ),
        )
      ]),
    );
  }
}

class RowData extends StatelessWidget {
  String title, value;
  RowData({Key? key, required this.title, required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
