import 'package:flutter/material.dart';
import 'package:lab4/data/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class DetailNews extends StatefulWidget {
  const DetailNews({super.key, required this.id});

  final int id;

  @override
  State<DetailNews> createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  NewsItem? _news;
  final now = DateTime.now();

  @override
  void initState() {
    _fetchItem(widget.id);
    super.initState();
  }

  _fetchItem(int id) async {
    final response = await http.get(Uri.parse('https://news-app-api.k8s.devebs.net/articles/$id'));
    var body = jsonDecode(utf8.decode(response.bodyBytes));
    var news = NewsItem.fromJson(body);
    setState(() {
      _news = news;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: _news != null ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 10.0),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      }, // Image tapped
                      child: Image.asset(
                        'assets/arrow.png',
                        fit: BoxFit.cover, // Fixes border issues
                        width: 14.0,
                        height: 12.0,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    child: Image.network(
                      _news?.image ?? '',
                      width: 360,
                      height: 252,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.amber,
                          alignment: Alignment.center,
                          child: const Text(
                            'Whoops!',
                            style: TextStyle(fontSize: 30),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 14.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        _news?.title ?? 'loading...',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromRGBO(235, 104, 297, 1)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        _news?.category.title ?? 'loading...',
                        style: const TextStyle(
                            color: Color.fromRGBO(255, 104, 97, 1),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(width: 25.33),
                    Image.asset('assets/views.png'),
                    const SizedBox(width: 5.33),
                    Text(NumberFormat.compact().format(_news?.views),
                        style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(44, 58, 75, 1))),
                    const SizedBox(width: 17.59),
                    Image.asset('assets/like.png'),
                    const SizedBox(width: 5.33),
                    Text(NumberFormat.compact().format(_news?.likes),
                        style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(44, 58, 75, 1))),
                    const SizedBox(width: 17.59),
                    Image.asset('assets/comments.png'),
                    const SizedBox(width: 5.33),
                    Text(NumberFormat.compact().format(_news?.comments),
                        style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(44, 58, 75, 1))),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                _news?.author.avatar ?? '',
                                width: 36,
                                height: 36,
                                fit: BoxFit.cover,),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                                child: Text(
                                  _news?.author.name ?? 'loading...',
                                  style: const TextStyle(
                                      color: Color.fromRGBO(255, 104, 97, 1),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(timeago.format(_news!.createdAt),
                                style: const TextStyle(
                                    color: Color.fromRGBO(44, 58, 75, 1),
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600),
                                maxLines: 1,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(255, 104, 97, 1),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24.0)),
                          ),
                        ),
                        child: const Text('+ Follow',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      _news?.description ?? 'loading...',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      _news?.content ?? 'loading...',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  itemCount: _news?.tags.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(255, 104, 97, 1)),
                            borderRadius: const BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Text(
                            "#${_news?.tags[index]}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color.fromRGBO(255, 104, 97, 1)),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ) : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
