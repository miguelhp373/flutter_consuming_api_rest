import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_consuming_rest_api/services/api_requests.dart';

class UsersListview extends StatelessWidget {
  const UsersListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            SizedBox(
              child: FutureBuilder<Response>(
                future: ApiRequest().fetchData('/users/all'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Erro ao carregar dados'));
                  } else {
                    var data = snapshot.data!.data['data'];
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var user = data[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/',
                              //arguments: user['id'],
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
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
