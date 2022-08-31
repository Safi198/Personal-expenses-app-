import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'new_transaction.dart';
import 'package:intl/intl.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String txt;
  final Function handler;
  AdaptiveFlatButton(this.txt,this.handler);
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? CupertinoButton(
      child: Text(
        txt,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: handler(),
    ) : FlatButton(
      textColor: Theme
          .of(context)
          .primaryColor,
      child: Text(
        txt,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: handler(),
    );
  }
}











