import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:knowit/models/collection.dart";
import "package:knowit/screens/collection_screen.dart";

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
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => CollectionScreen(
              collectionId: collection.id,
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
