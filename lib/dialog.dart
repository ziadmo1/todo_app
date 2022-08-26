import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

showMessage(BuildContext context,
    {required DialogType dialogType,
    required String desc,
    required VoidCallback onPressed,
    String? btnOkText
    }) {
  AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: dialogType,
      title: 'To Do List',
      desc: desc,
      btnOkOnPress:onPressed,
      btnOkText: btnOkText,
      descTextStyle: Theme.of(context).textTheme.bodyMedium,
      titleTextStyle: Theme.of(context).textTheme.bodyLarge,
      btnOkColor: Theme.of(context).primaryColor,
      dialogBackgroundColor: Theme.of(context).bottomAppBarColor)
    ..show();
}

void showLoading(BuildContext context, String message,
    {bool isCancelable = true}) {
  showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          backgroundColor: Theme.of(context).bottomAppBarColor,
          content: Row(
            children: [
              CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 15),
              )
            ],
          ),
        );
      },
      barrierDismissible: isCancelable);
}

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}
