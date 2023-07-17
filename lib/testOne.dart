import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restapiproject2/test/Products.dart';
import 'package:restapiproject2/test/TestModel.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  static Future<List<Products>> fetchData() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      /*final jsonData = jsonDecode(response.body) as List<dynamic>;
      final products = jsonData.map((item) => Products.fromJson(item)).toList();*/
      TestModel test = TestModel.fromJson(json.decode(response.body));
      return test.products ?? [];
    } else {
      return [];
    }
  }

  //Future<List<Products>>? _data;

  @override
  void initState() {
    super.initState();
    //_data = fetchData() as Future<List<Products>>?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JSON Data'),
      ),
      body: FutureBuilder<List<Products>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            //getting object in product
            final products = snapshot.data;
            return ListView.builder(
              itemCount: products?.length,
              itemBuilder: (context, index) {
                final product = products?[index];
                return ListTile(
                  leading: Text(product!.id.toString()),
                  title: Text(product!.title!),
                  subtitle: Text(product!.description!),
                );
              },
            );
          }
        },
      ),
    );
  }
}
