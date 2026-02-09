// import 'package:flutter/material.dart';
// import 'package:knowit/screens/collections_screen.dart';
// import 'package:knowit/tabs/overview_tab.dart';
// import 'package:knowit/tabs/stats_tab.dart';

// class TabsScreen extends StatelessWidget {
//   const TabsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('My tabs'),
//           bottom: TabBar(
//             tabs: [
//               Tab(icon: Icon(Icons.home_rounded), text: 'Home'),
//               Tab(icon: Icon(Icons.search_rounded), text: 'Search'),
//               Tab(icon: Icon(Icons.person_rounded), text: 'Profile'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [OverviewTab(), CollectionsScreen(), StatsTab()],
//         ),
//       ),
//     );
//   }
// }
