// class CardItem {
//   final String frontText;
//   final String backText;

//   CardItem({required this.frontText, required this.backText});
// }
import 'package:hive/hive.dart';

part 'card_item.g.dart';

@HiveType(typeId: 0)
class CardItem {
  @HiveField(0)
  final String frontText;

  @HiveField(1)
  final String backText;

  @HiveField(2)
  final String collectionId;

  @HiveField(3)
  final DateTime createdAt;

  CardItem({
    required this.frontText,
    required this.backText,
    required this.collectionId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
