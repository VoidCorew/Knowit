import "package:flutter/material.dart";

Widget emptyState(BuildContext context) {
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
