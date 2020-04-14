import 'package:flutter/material.dart';

class CustomDrawerTile extends StatelessWidget {
  final String text;
  final IconData iconData;
  final double textSize;

  final Function onPressed;

  CustomDrawerTile({this.text, this.iconData, this.textSize, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: MaterialButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Icon(
              iconData,
              color: Colors.black45,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.black45, fontSize: textSize),
            ),
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}
