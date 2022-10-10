import 'package:flutter/material.dart';
import 'package:notelist/utilities/messages.dart';

Future<void> showErrorDialog(BuildContext context,String e) {

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Row(children: const [Icon(Icons.warning, color: Colors.red,), Text(' ALERT')]),
        content: Text('Error detected during current process:\n"${errorCodeFormating(e)}"'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          )
        ]
      );
    }
  );
  
}

Future<bool> showLogOutDialog(BuildContext context) {

  return showDialog<bool>(context: context,
   builder:(context) {
    return AlertDialog(
      title: const Text('Sign Out'),
      content: const Text('Are you sure you want to sign out?'),
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop(false);
          }, 
          child: const Text('Cancel')
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('Sign Out'),
        )
      ],
    );  
  },
  ).then((value) => value ?? false);
  
}