import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String caption;
  final VoidCallback onPressed;

  const AdaptiveFlatButton({Key key, this.caption, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonCaption = Text(
      caption,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );

    return Platform.isIOS
        ? CupertinoButton(
            child: buttonCaption,
            onPressed: onPressed,
          )
        : FlatButton(
            textColor: Theme.of(context).primaryColor,
            child: buttonCaption,
            onPressed: onPressed,
          );
  }
}
