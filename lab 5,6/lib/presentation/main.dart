import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:lab4/presentation/pages/news.dart';
import 'package:lab4/presentation/pages/featured.dart';
import 'package:http/http.dart' as http;
import 'package:lab4/data/models.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

void main() {
  runApp(const MyApp());
}

List<NewsItem> parseNewsItems(results) {
  return results.map<NewsItem>((json) => NewsItem.fromJson(json)).toList();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'lab5',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'Source Sans Pro',
      ),
      home: const MyHomePage(title: 'lab5'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _featured = [];

  final _pagingController = PagingController<int, NewsItem>(
    firstPageKey: 1,
  );

  @override
  void initState() {
    _fetchFeaturedNews();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      var newsPage = await http.get(Uri.parse(
          'https://news-app-api.k8s.devebs.net/articles?is_featured=false&per_page=2&page=$pageKey'));
      var body = jsonDecode(utf8.decode(newsPage.bodyBytes));
      var results = parseNewsItems(body['results']);
      var totalPages = body['total_pages'];
      final isLastPage = pageKey == totalPages;

      if (isLastPage) {
        _pagingController.appendLastPage(results);
      } else {
        _pagingController.appendPage(results, pageKey + 1);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  _fetchFeaturedNews() async {
    var featured = await http.get(Uri.parse(
        'https://news-app-api.k8s.devebs.net/articles?is_featured=true'));
    setState(() {
      var body = jsonDecode(utf8.decode(featured.bodyBytes));
      _featured = parseNewsItems(body["results"]);
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
          FeaturedNewsHeader(featured: _featured),
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
          RefreshIndicator(
            onRefresh: () => Future.sync(
                  () => _pagingController.refresh(),
            ),
            child: SizedBox(
              height: 319.0,
              child: PagedListView.separated(
                pagingController: _pagingController,
                padding: const EdgeInsets.all(16),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
                builderDelegate: PagedChildBuilderDelegate<NewsItem>(
                  itemBuilder: (context, item, index) => News(newsItem: item),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}