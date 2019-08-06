import 'package:flutter/material.dart';
import '../constants/Constants.dart';
import '../events/change_words_event.dart';
class ResetButton extends StatelessWidget {
  void ResetWord() {
    Constants.eventBus.fire(ResetWordEvent());
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ResetWord();
        print(1);
      },
      child: Row(
        children: <Widget>[
          Icon(
            Icons.settings_input_svideo,
            size: 35.0,
          ),
          Text(
            '设置关键字',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
