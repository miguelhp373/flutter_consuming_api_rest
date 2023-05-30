// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_app_consuming_rest_api/components/dashboard_cards.dart';
import 'package:flutter_app_consuming_rest_api/components/users_listview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this); // Defina o número de abas aqui
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00B894),
        title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.people_alt)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            child: Container(
              color: const Color(0xFFFFFFFF),
              child: const Column(
                children: [
                  SizedBox(height: 10),
                  DashboardCards(
                    titleCardText: "Total Users",
                    valueCardText: "9999999",
                  ),
                ],
              ),
            ),
          ),
          const UsersListview(),
        ],
      ),
    );
  }
}
