import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab4/presentation/pages/detailNews.dart';
import 'package:lab4/data/models.dart';

class NewsList extends StatelessWidget {
  final List<NewsItem> news;

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
  final NewsItem newsItem;

  const News({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailNews(id: newsItem.id),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
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
              child: Image.network(
                newsItem.image,
                width: 150,
                height: 156,
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
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        newsItem.title,
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
                            child: Image.network(newsItem.author.avatar,
                                width: 18, height: 18, fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                          child: Text(
                            newsItem.author.name,
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
                            newsItem.category.title,
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
                            Text(NumberFormat.compact().format(newsItem.likes),
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Color.fromRGBO(44, 58, 75, 1))),
                            const SizedBox(width: 18.67),
                            Image.asset('assets/comments.png'),
                            const SizedBox(width: 5.33),
                            Text(NumberFormat.compact().format(newsItem.comments),
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
      ),
    );
  }
}