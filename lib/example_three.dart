import 'dart:convert';

import 'package:flutter/material.dart';
import 'Models/UsersModel.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatefulWidget {
  const ExampleThree({Key? key}) : super(key: key);

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<UsersModel> userList = [];

  Future<List<UsersModel>> getUsersApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    var data = jsonDecode(response.body.toString());

    // print(data);
    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UsersModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example Three Api' ),
      ),
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
            future: getUsersApi(),
            builder: (context, AsyncSnapshot<List<UsersModel>> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            RowData(
                                title: 'Name',
                                value: snapshot.data![index].name.toString()),
                            RowData(
                                title: 'Email',
                                value: snapshot.data![index].email.toString()),
                            RowData(
                                title: 'City',
                                value: snapshot.data![index].address!.city
                                    .toString()),
                            RowData(
                                title: 'Latitude',
                                value: userList[index].address!.geo!
                            .lat.toString()),
                          ],
                        ),
                      ),
                    );
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

//here row data class creating for minimize the code
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
