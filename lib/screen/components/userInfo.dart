import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uts_flutter/screen/login.dart';

class UserInfo extends StatefulWidget {
  final userData;

  const UserInfo({super.key, required this.userData});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  Future storePersistTokenOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences = await SharedPreferences.getInstance();
    preferences.setBool('isLogged', false);
    Navigator.of(context, rootNavigator: true).pop('dialog');
    Fluttertoast.showToast(
      msg: "Berhasil Logout",
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  Widget NameLine() {
    // inspect(userData);
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
              widget.userData.name,
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
              widget.userData.email,
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
              widget.userData.dateBirth,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 21,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Widget alertDelete() {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      scrollable: true,
      title: Text('Apa anda yakin?'),
      content: Container(
          width: 80.w,
          child: Icon(
            Icons.warning_amber_sharp,
            size: 40.sp,
            color: Colors.redAccent,
          )),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        Container(
          width: 40.w,
          height: 5.h,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
              onPressed: () {
                storePersistTokenOut();
              },
              child: Text('Ya Logout')),
        )
      ],
    );
  }

  Widget LogoutButton() {
    return Container(
      width: 90.w,
      height: 7.h,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red.shade400)),
        child: Text(
          "Logout",
          style: TextStyle(fontSize: 18.sp),
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return alertDelete();
              });
        },
      ),
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
        SizedBox(
          height: 50,
        ),
        LogoutButton()
      ],
    );
  }
}
