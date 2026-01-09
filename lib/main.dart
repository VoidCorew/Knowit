import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Knowit());
}

class Knowit extends StatelessWidget {
  const Knowit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Knowit",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.yellow,
          brightness: Brightness.light,
        ),
        fontFamily: "QuickSand",
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.yellowAccent,
          brightness: Brightness.dark,
        ),
        fontFamily: "QuickSand",
      ),
      home: HomeScreen(),
    );
  }
}

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
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: const Text("Preview tapped!")));
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

class CreateCollection extends StatefulWidget {
  const CreateCollection({super.key});

  @override
  State<CreateCollection> createState() => _CreateCollectionState();
}

class _CreateCollectionState extends State<CreateCollection> {
  final TextEditingController collectionName = TextEditingController();
  final TextEditingController collectionEmoji = TextEditingController();
  Color selectedColor = Colors.red;
  double progressValue = 0.72;

  final colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
  ];

  @override
  void initState() {
    super.initState();
    collectionName.addListener(_updatePreview);
    collectionEmoji.addListener(_updatePreview);
  }

  void _updatePreview() {
    setState(() {});
  }

  @override
  void dispose() {
    collectionName.dispose();
    collectionEmoji.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Collection")),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              SizedBox(
                height: constraints.maxHeight,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Divider(thickness: 2)),
                            Padding(
                              padding: const EdgeInsetsGeometry.symmetric(
                                horizontal: 8,
                              ),
                              child: const Text("Creation"),
                            ),
                            Expanded(child: Divider(thickness: 2)),
                          ],
                        ),

                        const SizedBox(height: 15),

                        TextField(
                          controller: collectionName,
                          maxLength: 32,
                          decoration: const InputDecoration(
                            labelText: "Collection name",
                            hintText: "e.g Biology, English B2",
                          ),
                          onChanged: (_) => setState(() {}),
                        ),

                        const SizedBox(height: 10),

                        TextField(
                          controller: collectionEmoji,
                          maxLength: 1,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: "Collection emoji",
                            hintText: "Enter an emoji",
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text("Picked color: "),
                        //         Container(
                        //           width: 30,
                        //           height: 30,
                        //           decoration: BoxDecoration(
                        //             shape: BoxShape.circle,
                        //             color: Colors.red,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     TextButton(onPressed: () {}, child: const Text("Pick")),
                        //   ],
                        // ),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: colors.map((color) {
                            return GestureDetector(
                              onTap: () =>
                                  setState(() => selectedColor = color),
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: color,
                                  border: selectedColor == color
                                      ? Border.all(
                                          width: 3,
                                          color: Colors.white,
                                        )
                                      : null,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.1,
                                      ),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 25),

                        Row(
                          children: [
                            Expanded(child: Divider(thickness: 2)),
                            Padding(
                              padding: const EdgeInsetsGeometry.symmetric(
                                horizontal: 8,
                              ),
                              child: const Text("Live Preview"),
                            ),
                            Expanded(child: Divider(thickness: 2)),
                          ],
                        ),

                        const SizedBox(height: 15),

                        collectionCard(context),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: _createButton(context),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _createButton(BuildContext context) {
    return ElevatedButton(
      onPressed: createCollection,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
      ),
      child: const Text(
        "Create Collection",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  void createCollection() {
    final name = collectionName.text.trim();
    final emoji = collectionEmoji.text.trim().isEmpty
        ? '📚'
        : collectionEmoji.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter collection name'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final newCollection = Collection(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      emoji: emoji,
      color: selectedColor,
      cardCount: 0,
      progress: 0.0,
    );

    Navigator.pop(context, newCollection);
  }

  Widget collectionCard(BuildContext context) {
    final theme = Theme.of(context);
    final emoji = collectionEmoji.text.trim().isEmpty
        ? '📚'
        : collectionEmoji.text.trim();
    final name = collectionName.text.trim().isEmpty
        ? 'Collection Name'
        : collectionName.text.trim();

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      surfaceTintColor: selectedColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: const Text("Preview tapped!")));
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
                      "$emoji $name",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "0 cards",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        // color: theme.colorScheme.onSurfaceVariant,
                        color: selectedColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Next review · 10 min",
                      style: theme.textTheme.labelMedium?.copyWith(
                        // color: theme.colorScheme.primary,
                        color: selectedColor,
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
                        value: progressValue,
                        strokeWidth: 6,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          selectedColor,
                        ),
                        backgroundColor:
                            theme.colorScheme.surfaceContainerHighest,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Text(
                      "${(progressValue * 100).toInt()}%",
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: selectedColor,
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
