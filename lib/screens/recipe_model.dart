import 'dart:io';

class Recipe {
  String title;
  List<File> images;
  List<String> ingredients;
  List<String> steps;
  List<String> tags;
  int likeCount;
  bool isLiked;
  List<String> comments;

  Recipe({
    required this.title,
    required this.images,
    required this.ingredients,
    required this.steps,
    required this.tags,
    this.likeCount = 0,
    this.isLiked = false,
    List<String>? comments,
  }) : comments = comments ?? [];
}
