import 'package:flutter/material.dart';
import 'package:flutter_app_consuming_rest_api/components/dashboard_cards.dart';
import 'package:flutter_app_consuming_rest_api/components/users_listview.dart';
import 'package:flutter_app_consuming_rest_api/controllers/users.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<String> _totalUsersFuture;
  late bool _isTabChanged;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _totalUsersFuture = Users().getTotalUserFromDataBase();
    _isTabChanged = false;

    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    setState(
      () => _tabController.index == 1
          ? _isTabChanged = true
          : _isTabChanged = false,
    );
  }

  Future<void> _refreshData() async {
    setState(() {
      _totalUsersFuture = Users().getTotalUserFromDataBase();
    });
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
          RefreshIndicator(
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              child: Container(
                color: const Color(0xFFFFFFFF),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    FutureBuilder<String>(
                      future: _totalUsersFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Text('Erro ao carregar dados');
                        } else {
                          String totalUsers = snapshot.data ?? "0";
                          return DashboardCards(
                            titleCardText: "Total Users",
                            valueCardText: totalUsers,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const UsersListview(),
        ],
      ),
      floatingActionButton: _isTabChanged
          ? FloatingActionButton(
              onPressed: () async {
                await Navigator.pushNamed(
                  context,
                  '/user-details',
                  arguments: '0',
                );
              },
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}
