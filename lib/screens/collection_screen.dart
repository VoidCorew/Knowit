import 'package:flutter/material.dart';
import 'package:knowit/models/card_item.dart';
import 'package:knowit/tabs/cards_tab.dart';
import 'package:knowit/tabs/overview_tab.dart';
import 'package:knowit/tabs/stats_tab.dart';

enum CollectionTab { overview, cards, stats }

class CollectionScreen extends StatefulWidget {
  final String collectionId;
  final String name;
  final String emoji;
  final Color color;
  final int cardCount;
  final double progress;
  final DateTime createdAt;

  const CollectionScreen({
    super.key,
    required this.collectionId,
    required this.name,
    required this.emoji,
    required this.color,
    required this.cardCount,
    required this.progress,
    required this.createdAt,
  });

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  CollectionTab _tab = CollectionTab.overview;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onColor = theme.colorScheme.onPrimaryContainer;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Row(
          children: [
            Text(widget.emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.name,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: onColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SegmentedButton<CollectionTab>(
                segments: const [
                  ButtonSegment(
                    value: CollectionTab.overview,
                    label: Text("Overview"),
                  ),
                  ButtonSegment(
                    value: CollectionTab.cards,
                    label: Text("Cards"),
                  ),
                  ButtonSegment(
                    value: CollectionTab.stats,
                    label: Text("Stats"),
                  ),
                ],
                selected: {_tab},
                onSelectionChanged: (value) {
                  setState(() => _tab = value.first);
                },
              ),

              const SizedBox(height: 16),

              // Expanded(child: _buildContent()),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: _buildContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_tab) {
      case CollectionTab.overview:
        return OverviewTab(
          color: widget.color,
          progress: widget.progress,
          cardCount: widget.cardCount,
        );
      case CollectionTab.cards:
        return CardsTab(
          // cards: [],
          collectionId: widget.collectionId,
          onAddCard: (CardItem p1) {},
          onDeleteCard: (CardItem p1) {},
        );
      case CollectionTab.stats:
        return StatsTab();
    }
  }
}
