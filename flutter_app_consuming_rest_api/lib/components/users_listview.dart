import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app_consuming_rest_api/components/show_modal_boolean.dart';
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

  void _deleteUserRequestAPI(String userId) async {
    Completer<bool> completer = Completer<bool>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowModalBoolean(
          completer: completer,
          isTitleModal: "Do you really want to delete the user",
          isMessageModal: "Delete user?",
        );
      },
    );

    bool? result = await completer.future;

    if (result) {
      http.Response response =
          await ApiRequest().deleteUserByID("/users/$userId");
      if (response.statusCode == 200) {
        _refreshData();
      }
    }
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
                        onTap: () async {
                          await Navigator.pushNamed(
                            context,
                            '/user-details',
                            arguments: user['id'],
                          );
                          _refreshData();
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user['image_link']),
                          ),
                          title: Text(user['name']),
                          trailing: IconButton(
                            onPressed: () {
                              _deleteUserRequestAPI(user['id']);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  throw Exception(
                    'Falha na requisição com código de status: ${response.statusCode}',
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
