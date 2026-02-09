// import 'package:flutter/material.dart';

// class Collection {
//   final String id;
//   final String name;
//   final String emoji;
//   final Color color;
//   final int cardCount;
//   final double progress;
//   final DateTime createdAt;

//   Collection({
//     required this.id,
//     required this.name,
//     required this.emoji,
//     required this.color,
//     this.cardCount = 0,
//     this.progress = 0.0,
//     DateTime? createdAt,
//   }) : createdAt = createdAt ?? DateTime.now();
// }

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'collection.g.dart';

@HiveType(typeId: 1)
class Collection {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String emoji;

  @HiveField(3)
  final int colorValue;

  @HiveField(4)
  final int cardCount;

  @HiveField(5)
  final double progress;

  @HiveField(6)
  final DateTime createdAt;

  Collection({
    required this.id,
    required this.name,
    required this.emoji,
    required this.colorValue,
    this.cardCount = 0,
    this.progress = 0.0,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Collection.fromColor({
    required String id,
    required String name,
    required String emoji,
    required Color color,
    int cardCount = 0,
    double progress = 0.0,
    DateTime? createdAt,
  }) {
    return Collection(
      id: id,
      name: name,
      emoji: emoji,
      colorValue: color.toARGB32(),
      cardCount: cardCount,
      progress: progress,
      createdAt: createdAt ?? DateTime.now(),
    );
  }

  Color get color => Color(colorValue);

  factory Collection.create({
    required String name,
    required String emoji,
    required Color color,
  }) {
    return Collection.fromColor(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      emoji: emoji,
      color: color,
    );
  }

  // Копировать с изменениями
  Collection copyWith({
    String? id,
    String? name,
    String? emoji,
    Color? color,
    int? cardCount,
    double? progress,
    DateTime? createdAt,
  }) {
    return Collection(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      colorValue: color?.toARGB32() ?? colorValue,
      cardCount: cardCount ?? this.cardCount,
      progress: progress ?? this.progress,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Collection && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Collection{id: $id, name: $name, emoji: $emoji, cardCount: $cardCount}';
  }
}
