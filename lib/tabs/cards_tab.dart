import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:knowit/models/card_item.dart';
import 'package:knowit/screens/create_card_screen.dart';
import 'package:knowit/services/hive_service.dart';

class CardsTab extends StatefulWidget {
  // final List<CardItem> cards;
  final String collectionId;
  final void Function(CardItem) onAddCard;
  final void Function(CardItem) onDeleteCard;

  const CardsTab({
    super.key,
    // required this.cards,
    required this.collectionId,
    required this.onAddCard,
    required this.onDeleteCard,
  });

  @override
  State<CardsTab> createState() => _CardsTabState();
}

class _CardsTabState extends State<CardsTab> {
  List<CardItem> filteredCards = [];
  final TextEditingController searchController = TextEditingController();
  bool multiSelectMode = false;
  final Set<CardItem> selectedCards = {};

  // String _currentSort = 'default';
  // String _currentFilter = 'all';

  @override
  void initState() {
    super.initState();
    // filteredCards = widget.cards;
    // filteredCards = HiveService.getAllCards();
    // filteredCards = HiveService.getCardsByCollection(collectionId);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // void filterCards(String query) {
  //   final allCards = HiveService.getAllCards();
  //   setState(() {
  //     filteredCards = allCards
  //         .where(
  //           (c) =>
  //               c.frontText.toLowerCase().contains(query.toLowerCase()) ||
  //               c.backText.toLowerCase().contains(query.toLowerCase()),
  //         )
  //         .toList();
  //   });
  // }

  void toggleSelect(CardItem card) {
    setState(() {
      if (selectedCards.contains(card)) {
        selectedCards.remove(card);
      } else {
        selectedCards.add(card);
      }
    });
  }

  // void deleteCard(CardItem card) {
  //   filteredCards.remove(card);
  // }

  // Future<void> deleteCard(int index) async {
  //   await HiveService.deleteCard(index);

  //   setState(() {
  //     filteredCards = HiveService.getAllCards();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: "Search cards",
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              searchController.clear();
                              setState(() {});
                              // filterCards("");
                            },
                          )
                        : null,
                  ),
                  // onChanged: filterCards,
                  onChanged: (_) => setState(() {}),
                ),

                // const SizedBox(height: 10),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(left: 8.0),
                //       child: Text(
                //         '${filteredCards.length} cards',
                //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                //           color: Theme.of(context).colorScheme.onSurfaceVariant,
                //         ),
                //       ),
                //     ),

                //     PopupMenuButton(
                //       icon: const Icon(Icons.filter_list_rounded),
                //       tooltip: 'Filter and sort',
                //       itemBuilder: (context) => [
                //         const PopupMenuItem(
                //           value: 'sort',
                //           child: ListTile(
                //             leading: Icon(Icons.sort_rounded),
                //             title: Text('Sort by'),
                //           ),
                //         ),
                //         const PopupMenuItem(
                //           value: 'filter',
                //           child: ListTile(
                //             leading: Icon(Icons.filter_alt_rounded),
                //             title: Text('Filter by'),
                //           ),
                //         ),
                //       ],
                //       onSelected: (value) {
                //         if (value == 'sort') {
                //           // _showSortOptions(context);
                //         } else if (value == 'filter') {
                //           // _showFilterOptions(context);
                //         }
                //       },
                //     ),
                //   ],
                // ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: ValueListenableBuilder<Box<CardItem>>(
              valueListenable: HiveService.cardsListenable,
              builder: (context, box, _) {
                // final cards = box.values.toList();

                final collectionCards = box.values
                    .where((card) => card.collectionId == widget.collectionId)
                    .toList();

                final displayedCards = searchController.text.isEmpty
                    ? collectionCards
                    : collectionCards
                          .where(
                            (card) =>
                                card.frontText.toLowerCase().contains(
                                  searchController.text.toLowerCase(),
                                ) ||
                                card.backText.toLowerCase().contains(
                                  searchController.text.toLowerCase(),
                                ),
                          )
                          .toList();

                final cardsCount = collectionCards.length;

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$cardsCount cards",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),

                          // PopupMenuButton(
                          //   icon: const Icon(Icons.filter_list_rounded),
                          //   tooltip: 'Filter and sort',
                          //   itemBuilder: (context) => [
                          //     const PopupMenuItem(
                          //       value: 'sort',
                          //       child: ListTile(
                          //         leading: Icon(Icons.sort_rounded),
                          //         title: Text('Sort by'),
                          //       ),
                          //     ),
                          //   ],
                          //   onSelected: (value) {
                          //     // Реализуйте сортировку
                          //   },
                          // ),

                          // ===============================
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.filter_list_rounded),
                            tooltip: 'Filter and sort',
                            itemBuilder: (context) {
                              return [
                                // Заголовок
                                PopupMenuItem(
                                  enabled: false,
                                  height: 40,
                                  child: Text(
                                    'SORT & FILTER',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                                const PopupMenuDivider(height: 4),

                                // Сортировка
                                const PopupMenuItem(
                                  value: 'name_asc',
                                  child: ListTile(
                                    dense: true,
                                    leading: Icon(
                                      Icons.sort_by_alpha_rounded,
                                      size: 20,
                                    ),
                                    title: Text('Name A → Z'),
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'name_desc',
                                  child: ListTile(
                                    dense: true,
                                    leading: Icon(
                                      Icons.sort_by_alpha_rounded,
                                      size: 20,
                                    ),
                                    title: Text('Name Z → A'),
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'date_new',
                                  child: ListTile(
                                    dense: true,
                                    leading: Icon(
                                      Icons.access_time_rounded,
                                      size: 20,
                                    ),
                                    title: Text('Date (Newest)'),
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'date_old',
                                  child: ListTile(
                                    dense: true,
                                    leading: Icon(
                                      Icons.access_time_rounded,
                                      size: 20,
                                    ),
                                    title: Text('Date (Oldest)'),
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'cards_asc',
                                  child: ListTile(
                                    dense: true,
                                    leading: Icon(
                                      Icons.numbers_rounded,
                                      size: 20,
                                    ),
                                    title: Text('Cards (Fewest)'),
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'cards_desc',
                                  child: ListTile(
                                    dense: true,
                                    leading: Icon(
                                      Icons.numbers_rounded,
                                      size: 20,
                                    ),
                                    title: Text('Cards (Most)'),
                                  ),
                                ),

                                const PopupMenuDivider(),

                                // Действия
                                const PopupMenuItem(
                                  value: 'reset',
                                  child: ListTile(
                                    dense: true,
                                    leading: Icon(
                                      Icons.restart_alt_rounded,
                                      size: 20,
                                      color: Colors.red,
                                    ),
                                    title: Text(
                                      'Reset filters',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ];
                            },
                            onSelected: (value) {
                              // Обработка выбора
                              debugPrint('Selected: $value');
                            },
                          ),
                        ],
                      ),
                    ),

                    displayedCards.isEmpty
                        ? Expanded(
                            child: Center(
                              child: Text(
                                searchController.text.isEmpty
                                    ? 'No cards in this collection'
                                    : 'No cards found',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.separated(
                              // itemCount: filteredCards.length,
                              itemCount: displayedCards.length,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(height: 8),
                              itemBuilder: (context, index) {
                                // final card = filteredCards[index];
                                final card = displayedCards[index];
                                return Slidable(
                                  endActionPane: ActionPane(
                                    motion: StretchMotion(),
                                    children: [
                                      SlidableAction(
                                        borderRadius: BorderRadius.circular(16),
                                        onPressed: (context) async {
                                          final allCards = box.values.toList();
                                          final cardIndex = allCards.indexOf(
                                            card,
                                          );
                                          if (cardIndex != -1) {
                                            await HiveService.deleteCard(
                                              cardIndex,
                                            );
                                          }
                                        },
                                        icon: Icons.delete_rounded,
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                      ),
                                    ],
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Card(
                                      elevation: 0,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surfaceContainerLow,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(16),
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                card.frontText,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              ),

                                              const SizedBox(height: 8),

                                              Text(
                                                card.backText,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurfaceVariant,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push<CardItem>(
            context,
            CupertinoPageRoute(
              builder: (_) => CreateCardScreen(
                collectionId: widget.collectionId,
                onCreate: (CardItem card) {
                  HiveService.addCard(card);
                },
              ),
            ),
          );

          // if (newCard != null) {
          //   setState(() {
          //     filteredCards.add(newCard);
          //   });
          // }
        },
        child: const Icon(Icons.add_to_photos_rounded),
      ),
    );
  }
}
