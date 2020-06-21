import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          margin: EdgeInsets.only(top:30),
          padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(children: <Widget>[
          Icon(
            FontAwesomeIcons.chevronLeft, 
            color: Colors.white,
            size: 20,
          ),
          Spacer(),
          Icon(
            FontAwesomeIcons.commentAlt, 
            color: Colors.white,
            size: 20,
          ),
          SizedBox(width: 20),
          Icon(
            FontAwesomeIcons.headphonesAlt, 
            color: Colors.white,
            size: 20,
          ),
          SizedBox(width: 20),
          Icon(
            FontAwesomeIcons.externalLinkAlt, 
            color: Colors.white,
            size: 20,
          ),

        ],)
      ),
    );
  }
}