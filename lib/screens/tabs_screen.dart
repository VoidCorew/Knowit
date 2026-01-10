import 'package:flutter/material.dart';
import 'package:knowit/screens/home_screen.dart';
import 'package:knowit/screens/overview_screen.dart';
import 'package:knowit/screens/stats_screen.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Мои вкладки'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Главная'),
              Tab(icon: Icon(Icons.search), text: 'Поиск'),
              Tab(icon: Icon(Icons.person), text: 'Профиль'),
            ],
          ),
        ),
        body: TabBarView(
          children: [OverviewScreen(), HomeScreen(), StatsScreen()],
        ),
      ),
    );
  }
}
