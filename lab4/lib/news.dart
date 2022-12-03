import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsList extends StatelessWidget {
  final List news;

  const NewsList({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 319.0,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[for (var item in news) News(newsItem: item)],
      ),
    );
  }
}

class News extends StatelessWidget {
  final dynamic newsItem;

  const News({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(235, 238, 242, 1)),
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              bottomLeft: Radius.circular(16.0),
            ),
            child: Image.network(newsItem["cover"],
                width: 150, height: 156, fit: BoxFit.cover),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      newsItem["title"],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          color: Color.fromRGBO(44, 58, 75, 1),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(newsItem["portal"]["logo"],
                              width: 18, height: 18, fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: Text(
                          newsItem['portal']['title'],
                          style: const TextStyle(
                              color: Color.fromRGBO(44, 58, 75, 1),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600),
                          maxLines: 1,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromRGBO(235, 104, 297, 1)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          newsItem["category"],
                          style: const TextStyle(
                              color: Color.fromRGBO(255, 104, 97, 1),
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset('assets/like.png'),
                          const SizedBox(width: 5.33),
                          Text(
                              NumberFormat.compact()
                                  .format(newsItem["likes"].toDouble()),
                              style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Color.fromRGBO(44, 58, 75, 1))),
                          const SizedBox(width: 18.67),
                          Image.asset('assets/comments.png'),
                          SizedBox(width: 5.33),
                          Text(
                              NumberFormat.compact()
                                  .format(newsItem["comments"].toDouble()),
                              style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Color.fromRGBO(44, 58, 75, 1))),
                        ],
                      ),
                      Column(
                        children: [Image.asset('assets/saved.png')],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
