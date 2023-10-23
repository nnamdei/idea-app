import 'package:flutter/material.dart';

class Idea {
  final int? id;
  final String? title;
  final String? description;
  final ValueNotifier<int>? upvotes;
  final ValueNotifier<int>? downvotes;

  Idea({
    this.id,
    this.title,
    this.description,
    this.upvotes,
    this.downvotes,
  });

  factory Idea.fromMap(Map<String, dynamic> map) {
    return Idea(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      upvotes: ValueNotifier(map['upvotes']),
      downvotes: ValueNotifier(map['downvotes']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'upvotes': upvotes?.value,
      'downvotes': downvotes?.value,
    };
  }

  Map<String, dynamic> upVotesMap() {
    return {
      'id': id,
      'upvotes': upvotes?.value,
    };
  }

  Map<String, dynamic> downVotesMap() {
    return {
      'id': id,
      'downvotes': downvotes?.value,
    };
  }
}
