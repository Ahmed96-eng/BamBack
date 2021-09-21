import 'package:flutter/material.dart';

goTo(context, Widget screenWidget) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screenWidget,
      ));
}

goToAndFinish(context, Widget screenWidget) {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => screenWidget,
      ));
}

back(context) {
  Navigator.pop(context);
}
