import 'dart:math';

class Author {
  final int id;
  final String name;
  final DateTime modifiedAt;
  final DateTime createdAt;
  final String avatar;

  Author({
    required this.id,
    required this.name,
    required this.modifiedAt,
    required this.createdAt,
    required this.avatar,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      name: json['name'],
      modifiedAt: DateTime.parse(json['modified_at']),
      createdAt: DateTime.parse(json['created_at']),
      avatar: json['avatar'],
    );
  }
}

class Category {
  final int id;
  final String title;
  final DateTime modifiedAt;
  final DateTime createdAt;

  Category({
    required this.id,
    required this.title,
    required this.modifiedAt,
    required this.createdAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      modifiedAt: DateTime.parse(json['modified_at']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class NewsItem {
  final Author author;
  final Category category;
  final List<String> tags;
  final int id;
  final DateTime modifiedAt;
  final DateTime createdAt;
  final String title;
  final String description;
  final String content;
  final String image;
  final int views;
  final int likes;
  final int comments;
  final bool isFeatured;

  NewsItem({
    required this.author,
    required this.category,
    required this.tags,
    required this.id,
    required this.modifiedAt,
    required this.createdAt,
    required this.title,
    required this.description,
    required this.content,
    required this.image,
    required this.views,
    required this.likes,
    required this.comments,
    required this.isFeatured,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
        author: Author.fromJson(json['author']),
        category: Category.fromJson(json['category']),
        tags: List<String>.from(json['tags']),
        id: json['id'],
        modifiedAt: DateTime.parse(json['modified_at']),
        createdAt: DateTime.parse(json['created_at']),
        title: json['title'],
        description: json['description'],
        content: json['content'],
        image: json['image'],
        views: json['views_count'],
        likes: Random().nextInt(json['views_count']),
        comments: Random().nextInt(json['views_count']),
        isFeatured: json['is_featured']);
  }
}