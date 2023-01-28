import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './dash.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './../model/user.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  _LoginState createState() => _LoginState();
}

Widget forgotPassBtn() {
  return Container(
    alignment: Alignment.centerRight,
    child: TextButton(
        onPressed: () => {print('Forgot')},
        child: Text(
          'Forgot Password?',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
  );
}

class _LoginState extends State<Login> {
  String idU = '';
  late SharedPreferences preferences;
  bool isHidden = true;

  Future init() async {
    preferences = await SharedPreferences.getInstance();
    final userJson = preferences.getString('user');
    if (userJson == null) return;

    final user = User.fromJson(jsonDecode(userJson));
    setState(() => this.user = user);
    bool? isLogged = preferences.getBool('isLogged');
    if (isLogged == true) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Dashboard(
                    user: user,
                  )));
    }
  }

  var user;
  final EmailCon = TextEditingController();
  final PassCon = TextEditingController();
  final NameCon = TextEditingController();
  final dateInput = TextEditingController();
  String regisEmail = "";
  String regisPass = "";
  bool isRegis = false;
  DateTime? dateTime;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    EmailCon.dispose();
    super.dispose();
  }

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
    init();
  }

  Future storePersist(dateInput) async {
    final user = User(
      email: regisEmail,
      name: NameCon.text,
      password: regisPass,
      dateBirth: dateInput,
    );
    final userJson = jsonEncode(user.toJson());
    preferences.setString('user', userJson);
    setState(() => this.user = user);
  }

  Future storePersistTokenIn() async {
    preferences = await SharedPreferences.getInstance();
    preferences.setBool('isLogged', true);
  }

  Widget emailBuilder(myConE) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            onChanged: (value) {
              if (isRegis) {
                setState(() {
                  regisEmail = value;
                });
              }
            },
            controller: myConE,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.email,
                  color: Color(0xffef6b63),
                ),
                hintText: 'Email ',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget passwordBuilder(myConP) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            onChanged: (value) {
              if (isRegis) {
                setState(() {
                  regisPass = value;
                });
              }
            },
            controller: myConP,
            obscureText: isHidden,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0xffef6b63),
              ),
              hintText: 'Password ',
              hintStyle: TextStyle(color: Colors.black38),
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    isHidden = !isHidden;
                  });
                },
                child: Icon(
                  Icons.visibility,
                  color: Color(0xffef6b63),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget nameBuilder(myConN) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            controller: myConN,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.person,
                  color: Color(0xffef6b63),
                ),
                hintText: 'Name ',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  //             print(
  //                 pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
  //             String formattedDate =
  //                 DateFormat('yyyy-MM-dd').format(pickedDate);
  //             print(
  //                 formattedDate); //formatted date output using intl package =>  2021-03-16
  //             setState(() {
  //               dateInput.text =
  //                   formattedDate; //set output date to TextField value.
  //             });
  //           } else {}
  //         },
  //       )));
  // }
  Widget dateBuilder(myConD) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date on Birth',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextField(
              controller: myConD,
              //editing controller of this TextField
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: Color(0xffef6b63),
                  ),
                  hintText: 'Enter Date ',
                  hintStyle: TextStyle(color: Colors.black38)),

              readOnly: true,
              //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1960),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2100));

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  setState(() {
                    dateInput.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {}
              },
            ))
      ],
    );
  }

  Widget loginBtn(context, EmailCon, PassCon, dateInput, NameCon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.white))),
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        onPressed: () => {
          // inspect(this.user),
          if (isRegis == false && this.user == null)
            {
              Fluttertoast.showToast(
                msg:
                    "Tidak ada akun yang tersimpan di device ini, silahkan register",
                toastLength: Toast.LENGTH_LONG,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.redAccent,
                textColor: Colors.white,
                fontSize: 16.0,
              ),
            }
          else if (isRegis == false &&
              EmailCon.text == this.user.email &&
              PassCon.text == this.user.password)
            {
              storePersistTokenIn(),
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      // builder: (context) {
                      //   return Dasboard(UserData : {EmailCon.text,PassCon.text,dateInput.text,NameCon.text});
                      // },
                      builder: (context) => Dashboard(
                            // Email: EmailCon.text,
                            // Name: NameCon.text,
                            // DateBirth: dateInput.text.toString(),
                            // Password: PassCon.text
                            user: this.user,
                          )))
              //   builder: (context) => const Dasboard(),
              //   // Pass the arguments as part of the RouteSettings. The
              //   // DetailScreen reads the arguments from these settings.
              //   settings: RouteSettings(
              //     arguments: {
              //       EmailCon.text,
              //       PassCon.text,
              //       dateInput.text,
              //       NameCon.text
              //     },
              //   ),
              // ))
            }
          else if (isRegis == false &&
              regisEmail != this.user.email &&
              regisPass != this.user.password)
            {
              Fluttertoast.showToast(
                msg: "password atau email salah",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.redAccent,
                textColor: Colors.white,
                fontSize: 16.0,
              )
            }
          else if (regisEmail == "" || regisPass == "")
            {
              if (isRegis == true)
                {
                  Fluttertoast.showToast(
                    msg: "Data Tidak Lengkap",
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.redAccent,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  )
                }
            }
          else if (isRegis == true && regisEmail != "" && regisPass != "")
            {
              Fluttertoast.showToast(
                msg: "Register berhasil",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.greenAccent,
                textColor: Colors.white,
                fontSize: 16.0,
              ),
              EmailCon.clear(),
              PassCon.clear(),
              setState((() {
                isRegis = !isRegis;
              })),
              // nanti masukin ke shared preferences data usernya disini
              storePersist(dateInput = dateInput.text.toString())
            }
          else
            {
              Fluttertoast.showToast(
                msg: "Lengkapi Data",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.redAccent,
                textColor: Colors.white,
                fontSize: 16.0,
              ),
            }
        },
        child: Text(
          isRegis ? "Register" : "Login",
          style: TextStyle(
              color: Color(0xffef6b63),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget registerBtn(context, EmailCon, PassCon) {
    return Container(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.white))),
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        onPressed: () => {
          setState(() {
            isRegis = !isRegis;
          })
        },
        child: Text(
          isRegis ? "Back" : "Register",
          style: TextStyle(
              color: Color(0xffef6b63),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x66ef6b63),
                        Color(0x99ef6b63),
                        Color(0xccef6b63),
                        Color(0xffef6b63),
                      ]),
                ),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isRegis ? "SignUp" : "Sign In",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      emailBuilder(EmailCon),
                      SizedBox(
                        height: 20,
                      ),
                      passwordBuilder(PassCon),
                      SizedBox(
                        height: 20,
                      ),
                      isRegis ? dateBuilder(dateInput) : Center(),
                      isRegis
                          ? SizedBox(
                              height: 20,
                            )
                          : Center(),
                      !isRegis ? forgotPassBtn() : nameBuilder(NameCon),
                      isRegis
                          ? SizedBox(
                              height: 20,
                            )
                          : Center(),
                      loginBtn(context, EmailCon, PassCon, dateInput, NameCon),
                      registerBtn(context, EmailCon, PassCon),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
