import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UserInfo extends StatelessWidget {
  final userData;
  const UserInfo({super.key, required this.userData});

  Widget NameLine() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "Name ",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 21,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
            flex: 1,
            child: Text(
              userData["Name"],
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 21,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Widget EmailLine() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "Email ",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 21,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
            flex: 1,
            child: Text(
              userData["Email"],
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 21,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Widget DateofBirthLine() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "Date of Birth ",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 21,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
            flex: 1,
            child: Text(
              userData["DateBirth"],
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 21,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.all(20.0),
      children: <Widget>[
        Center(
          child: Icon(
            Icons.person,
            size: 150,
          ),
        ),
        SizedBox(
          height: 50,
        ),
        NameLine(),
        Divider(color: Colors.black12),
        SizedBox(
          height: 20,
        ),
        EmailLine(),
        Divider(color: Colors.black12),
        SizedBox(
          height: 20,
        ),
        DateofBirthLine(),
        Divider(color: Colors.black12),
      ],
    );
  }
}
