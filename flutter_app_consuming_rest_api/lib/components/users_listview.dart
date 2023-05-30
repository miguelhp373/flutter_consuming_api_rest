// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_app_consuming_rest_api/services/api_requests.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsersListview extends StatefulWidget {
  const UsersListview({Key? key}) : super(key: key);

  @override
  _UsersListviewState createState() => _UsersListviewState();
}

class _UsersListviewState extends State<UsersListview> {
  late Future<http.Response> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = ApiRequest().fetchData('/users/all');
  }

  Future<void> _refreshData() async {
    setState(() {
      _userDataFuture = ApiRequest().fetchData('/users/all');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.7,
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: FutureBuilder<http.Response>(
            future: _userDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Erro ao carregar dados'));
              } else {
                var response = snapshot.data!;
                if (response.statusCode == 200) {
                  var jsonResponse = jsonDecode(response.body);
                  var data = List.from(jsonResponse);
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var user = data[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/user-details',
                            arguments: user['id'],
                          );
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user['image_link']),
                          ),
                          title: Text(user['name']),
                          //subtitle: Text(user['email']),
                        ),
                      );
                    },
                  );
                } else {
                  throw Exception(
                      'Falha na requisição com código de status: ${response.statusCode}');
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
