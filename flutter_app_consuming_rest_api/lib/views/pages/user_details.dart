// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_app_consuming_rest_api/components/show_bottom_alert.dart';
import 'package:flutter_app_consuming_rest_api/services/api_requests.dart';
import 'dart:convert';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late String _userId;
  final TextEditingController _nameController = TextEditingController();
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

    if (_userId == '0') {
      setState(() {
        _isEditing = true;
        _nameController.text = '';
        _userImage =
            'https://static.vecteezy.com/system/resources/thumbnails/004/511/281/small/default-avatar-photo-placeholder-profile-picture-vector.jpg';
      });

      return;
    }
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
    }
  }

  void _editUser() {
    setState(() => _isEditing = true);
  }

  void _saveUser() async {
    final newName = _nameController.text;

    if (_userId == '0') {
      final response = await ApiRequest().postDataByUserID(
        '/users',
        {'name': newName},
      );
      if (response.statusCode == 200) {
        Navigator.of(context).pop();
      } else {
        ShowBottomAlert().showBottomAlert(
            context, "Request Error - Cannot complete this operation.");
      }
    } else {
      final response = await ApiRequest().patchDataByUserID(
        '/users/$_userId',
        {'name': newName},
      );
      if (response.statusCode == 200) {
        Navigator.of(context).pop();
      } else {
        ShowBottomAlert().showBottomAlert(
            context, "Request Error - Cannot complete this operation.");
      }
    }
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
            const SizedBox(height: 16),
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
