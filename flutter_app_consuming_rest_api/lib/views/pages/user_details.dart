// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_app_consuming_rest_api/services/api_requests.dart';
import 'dart:convert';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late String _userId;
  TextEditingController _nameController = TextEditingController();
  bool _isEditing = false;
  String _userImage = '';

  @override
  void initState() {
    super.initState();
    _userId = '';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userId = ModalRoute.of(context)!.settings.arguments as String;
    _fetchUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserData() async {
    final response = await ApiRequest().fetchDataByUserID('/users/$_userId');
    if (response.statusCode == 200) {
      final userList = jsonDecode(response.body) as List;
      final user = userList.first;
      final userProfileImage = user['image_link'];
      final userName = user['name'];
      setState(() {
        _nameController.text = userName;
        _userImage = userProfileImage;
      });
    } else {
      // Handle error
    }
  }

  void _editUser() {
    setState(() {
      _isEditing = true;
    });
  }

  void _saveUser() async {
    final newName = _nameController.text;
    final response = await ApiRequest()
        .patchDataByUserID('/users/$_userId', {'name': newName});
    if (response.statusCode == 200) {
      print('Alterado com sucesso');
    } else {
      print('Tente Novamente.');
    }
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(_userImage),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _isEditing
                  ? TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                    )
                  : Text(
                      _nameController.text,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            SizedBox(height: 16),
            _isEditing
                ? ElevatedButton(
                    onPressed: _saveUser,
                    child: const Text('Save'),
                  )
                : ElevatedButton(
                    onPressed: _editUser,
                    child: const Text('Edit'),
                  ),
          ],
        ),
      ),
    );
  }
}
