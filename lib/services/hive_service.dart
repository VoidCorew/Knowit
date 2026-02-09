import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:knowit/models/card_item.dart';
import 'package:knowit/models/collection.dart';

class HiveService {
  static late Box<CardItem> _cardsBox;
  static late Box<Collection> _collectionsBox;

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(CardItemAdapter());
    Hive.registerAdapter(CollectionAdapter());

    _cardsBox = await Hive.openBox<CardItem>("cards");
    _collectionsBox = await Hive.openBox<Collection>("collections");
  }

  static Future<void> addCard(CardItem card) async {
    await _cardsBox.add(card);

    final collections = _collectionsBox.values.toList();
    for (int i = 0; i < collections.length; i++) {
      if (collections[i].id == card.collectionId) {
        final updated = collections[i].copyWith(
          cardCount: collections[i].cardCount + 1,
        );
        await _collectionsBox.putAt(i, updated);
        break;
      }
    }
  }

  static List<CardItem> getCardsByCollection(String collectionId) {
    return _cardsBox.values
        .where((card) => card.collectionId == collectionId)
        .toList();
  }

  static Future<void> deleteCard(int index) async {
    final card = _cardsBox.getAt(index);

    if (card != null) {
      await _cardsBox.deleteAt(index);

      final collections = _collectionsBox.values.toList();
      for (int i = 0; i < collections.length; i++) {
        if (collections[i].id == card.collectionId) {
          final updated = collections[i].copyWith(
            cardCount: collections[i].cardCount - 1,
          );
          await _collectionsBox.putAt(index, updated);
          break;
        }
      }
    }
  }

  static List<Collection> getAllCollections() {
    return _collectionsBox.values.toList();
  }

  static Future<void> addCollection(Collection collection) async {
    await _collectionsBox.add(collection);
  }

  static Future<void> deleteCollection(int index) async {
    final collection = _collectionsBox.getAt(index);
    if (collection != null) {
      final cards = getCardsByCollection(collection.id);
      for (final card in cards) {
        final allCards = _cardsBox.values.toList();
        final cardIndex = allCards.indexOf(card);
        if (cardIndex != -1) {
          await _cardsBox.deleteAt(cardIndex);
        }
      }
      await _collectionsBox.deleteAt(index);
    }
  }

  // ===================== Cards Box =====================
  // static Future<void> addCard(CardItem card) async {
  //   await _cardsBox.add(card);
  // }

  // static List<CardItem> getAllCards() {
  //   return _cardsBox.values.toList();
  // }

  // static Future<void> deleteCard(int index) async {
  //   await _cardsBox.deleteAt(index);
  // }

  // static Future<void> updateCard(int index, CardItem card) async {
  //   await _cardsBox.putAt(index, card);
  // }

  // static Future<void> clearAll() async {
  //   await _cardsBox.clear();
  // }

  static ValueListenable<Box<CardItem>> get cardsListenable {
    return _cardsBox.listenable();
  }

  // ===================== Collection Box =====================

  static ValueListenable<Box<Collection>> get collectionsListenable {
    return _collectionsBox.listenable();
  }

  // static Future<void> addCollection(Collection collection) async {
  //   await _collectionsBox.add(collection);
  // }

  // static List<Collection> getAllCollections() {
  //   return _collectionsBox.values.toList();
  // }

  // static Future<void> updateCollection(int index, Collection collection) async {
  //   await _collectionsBox.putAt(index, collection);
  // }

  // static Future<void> deleteCollection(int index) async {
  //   await _collectionsBox.deleteAt(index);
  // }
}
