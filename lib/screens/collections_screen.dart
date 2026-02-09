import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:knowit/models/collection.dart';
import 'package:knowit/screens/create_collection_screen.dart';
import 'package:knowit/services/hive_service.dart';
import 'package:knowit/widgets/collection_card.dart';
import 'package:knowit/widgets/empty_state.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({super.key});

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  // final List<Collection> collections = [];

  // void addCollection(Collection newCollection) {
  //   setState(() {
  //     collections.add(newCollection);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Collections")),
      // body: collections.isEmpty ? emptyState(context) : collectionsList(),
      body: ValueListenableBuilder<Box<Collection>>(
        valueListenable: HiveService.collectionsListenable,
        builder: (context, box, _) {
          final collections = box.values.toList();

          if (collections.isEmpty) {
            return emptyState(context);
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.separated(
              itemBuilder: (context, index) {
                final collection = collections[index];
                return collectionCard(collection, context);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemCount: collections.length,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newCollection = await Navigator.push<Collection?>(
            context,
            CupertinoPageRoute(builder: (_) => CreateCollectionScreen()),
          );

          if (newCollection != null) {
            // addCollection(newCollection);
            await HiveService.addCollection(newCollection);
          }
        },
        label: const Text("New Collection"),
        icon: const Icon(Icons.add_rounded),
      ),
    );
  }

  // Widget collectionsList() {
  //   return Padding(
  //     padding: const EdgeInsets.all(16),
  //     child: ListView.separated(
  //       itemBuilder: (context, index) {
  //         final collection = collections[index];
  //         return collectionCard(collection, context);
  //       },
  //       separatorBuilder: (context, index) => const SizedBox(height: 12),
  //       itemCount: collections.length,
  //     ),
  //   );
  // }
}
