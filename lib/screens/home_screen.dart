import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowit/models/collection.dart';
import 'package:knowit/screens/collection_screen.dart';
import 'package:knowit/screens/create_collection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Collection> collections = [];

  void addCollection(Collection newCollection) {
    setState(() {
      collections.add(newCollection);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Collections")),
      body: collections.isEmpty ? emptyState() : collectionsList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newCollection = await Navigator.push<Collection?>(
            context,
            CupertinoPageRoute(builder: (_) => CreateCollection()),
          );

          if (newCollection != null) {
            addCollection(newCollection);
          }
        },
        label: const Text("New Collection"),
        icon: const Icon(Icons.add_rounded),
      ),
    );
  }

  Widget emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.collections_bookmark_rounded,
            size: 80,
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            "No collections yet",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Tap the + button to create your first collection",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget collectionsList() {
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
  }

  Widget collectionCard(Collection collection, BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      surfaceTintColor: collection.color,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          // ScaffoldMessenger.of(
          //   context,
          // ).showSnackBar(SnackBar(content: const Text("Preview tapped!")));
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => CollectionScreen(
                name: collection.name,
                emoji: collection.emoji,
                color: collection.color,
                cardCount: collection.cardCount,
                progress: collection.progress,
                createdAt: collection.createdAt,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${collection.emoji} ${collection.name}",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "0 cards",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        // color: theme.colorScheme.onSurfaceVariant,
                        color: collection.color,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Next review · 10 min",
                      style: theme.textTheme.labelMedium?.copyWith(
                        // color: theme.colorScheme.primary,
                        color: collection.color,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                width: 80,
                height: 80,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 65,
                      height: 65,
                      child: CircularProgressIndicator(
                        padding: const EdgeInsets.all(8.0),
                        value: collection.progress,
                        strokeWidth: 6,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          collection.color,
                        ),
                        backgroundColor:
                            theme.colorScheme.surfaceContainerHighest,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Text(
                      "${(collection.progress * 100).toInt()}%",
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: collection.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
