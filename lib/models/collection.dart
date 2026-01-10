import 'package:flutter/material.dart';

class Collection {
  final String id;
  final String name;
  final String emoji;
  final Color color;
  final int cardCount;
  final double progress;
  final DateTime createdAt;

  Collection({
    required this.id,
    required this.name,
    required this.emoji,
    required this.color,
    this.cardCount = 0,
    this.progress = 0.0,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
