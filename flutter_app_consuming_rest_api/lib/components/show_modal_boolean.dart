import 'dart:async';

import 'package:flutter/material.dart';

class ShowModalBoolean extends StatelessWidget {
  const ShowModalBoolean({
    Key? key,
    required this.completer,
    required this.isTitleModal,
    required this.isMessageModal,
  }) : super(key: key);

  final Completer<bool> completer;
  final String isTitleModal;
  final String isMessageModal;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isTitleModal),
      content: Text(isMessageModal),
      actions: [
        TextButton(
          child: const Text('Yes'),
          onPressed: () {
            completer.complete(true);
            Navigator.of(context).pop(true);
          },
        ),
        TextButton(
          child: const Text('No'),
          onPressed: () {
            completer.complete(false);
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}
