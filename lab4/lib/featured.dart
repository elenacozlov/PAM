import 'package:flutter/material.dart';

class FeaturedNewsHeader extends StatelessWidget {
  final List featured;

  const FeaturedNewsHeader({
    Key? key,
    required this.featured,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0,
      child: ListView(
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (var item in featured) FeaturedNews(newsItem: item)
        ],
      ),
    );
  }
}

class FeaturedNews extends StatelessWidget {
  final dynamic newsItem;
  const FeaturedNews({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0, left: 16.0),
      child: Container(
        width: 310.0,
        height: 252.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(newsItem["cover"]),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                newsItem["title"],
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(254, 131, 125, 1),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  ),
                ),
                child: const Text('Read Now', style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
