import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var Data;
  List listData = [];
  late Map mapData = {};
  List facts = [];
  Future fetchData() async {
    http.Response response;

    Uri uri = Uri.parse("https://thegrowingdeveloper.org/apiview?id=2");
    response = await http.get(uri);
    setState(() {
      if (response.statusCode == 200) {
        mapData = json.decode(response.body);
        facts = mapData['facts'];
      } else {
        Data = "Onnum ela";
      }
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.network(
                        facts[index]['image_url'],
                      ),
                      Text(
                        facts[index]['title'].toString(),
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        facts[index]['description'].toString(),
                        style: const TextStyle(fontSize: 23),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                );
              },
              itemCount: facts.length,
            )
          ],
        ),
      ),
    );
  }
}
