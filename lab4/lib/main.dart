import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:lab4/news.dart';
import 'package:lab4/featured.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'lab4',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'Source Sans Pro',
      ),
      home: const MyHomePage(title: 'lab4'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

// Fields in a Widget subclass are always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var featured = [];
  var news = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  fetchNews() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/news.json");
    var resp = jsonDecode(data);
    setState(() {
      featured = resp["featured"];
      news = resp["news"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 30, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(
                  "Featured",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(44, 58, 75, 1)),
                ),
                Text(
                  "See all",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 104, 97, 1)),
                )
              ],
            ),
          ),
          FeaturedNewsHeader(featured: featured),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 22, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(
                  "News",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(44, 58, 75, 1)),
                ),
                Text(
                  "See all",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 104, 97, 1)),
                )
              ],
            ),
          ),
          NewsList(news: news),
        ],
      ),
    );
  }
}
