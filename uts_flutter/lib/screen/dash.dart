import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uts_flutter/api/api.dart';
import 'package:uts_flutter/screen/components/vaultDetail.dart';
import './components/userInfo.dart';
import './components/grid.dart';
import './components/vaultList.dart';
import './../model/user.dart';
import 'dart:developer' as logDev;
import 'package:responsive_sizer/responsive_sizer.dart';

// class UserData {
//   final String title;
//   final String description;

//   const UserData(this.title, this.description);
// }

class Dashboard extends StatefulWidget {
  // String Name, Email, DateBirth, Password;
  // const Dasboard({super.key});

  // Dashboard(
  //     {Key? key,
  //     required this.Name,
  //     required this.Email,
  //     required this.DateBirth,
  //     required this.Password})
  //     : super(key: key);
  var user;
  Dashboard({Key? key, required this.user}) : super(key: key);
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  // var user;
  Api _api = Api();
  late SharedPreferences preferences;
  late String password_input;
  late String title_input;
  late String username_input;
  late String comment;
  late var vaultItem;
  bool vaultDetailOpened = false;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    preferences = await SharedPreferences.getInstance();
    final userJson = preferences.getString('user');
    if (userJson == null) return;

    final user = User.fromJson(jsonDecode(userJson));
    // setState(() => this.user = user);
    // inspect(widget.user);
  }

  late final _userData = {
    // "Name": widget.Name,
    // "Email": widget.Email,
    // "DateBirth": widget.DateBirth,
    // "Password": widget.Password,
    "user": widget.user
  };

  int selectedIndex = 0;
  void toggleOnVaultDetail(item) {
    setState(() {
      this.vaultDetailOpened = true;
    });
    setState(() {
      this.vaultItem = item;
    });
    // inspect(item);
    Fluttertoast.showToast(
      msg: "toggle terpencet",
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void toggleOffVaultDetail() {
    setState(() {
      this.vaultDetailOpened = false;
    });
  }

  late final List<Widget> _pages = <Widget>[
    VaultList(
      toggleOnVaultDetail: (item) {
        toggleOnVaultDetail(item);
      },
    ),
    UserInfo(userData: widget.user),
    // Icon(
    //   Icons.dangerous_outlined,
    //   size: 150,
    // ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    setState(() {
      vaultDetailOpened = false;
    });
  }

  postVault() async {
    bool response = await _api.postVault(this.title_input, this.password_input);

    if (response) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      return Fluttertoast.showToast(
        msg: "mantap berhasil",
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      print(response);
      return Fluttertoast.showToast(
        msg: "gagal bro",
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  postVaultItem() async {
    bool response = await _api.postVaultItem(
        this.vaultItem.id,
        this.title_input,
        this.username_input,
        this.password_input,
        this.comment);

    if (response) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      inspect(response);
      return Fluttertoast.showToast(
        msg: "mantap berhasil",
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      print(response);
      return Fluttertoast.showToast(
        msg: "gagal bro",
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Widget alertTambahVault() {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      scrollable: true,
      title: Text('Add new vault'),
      content: Container(
        width: 80.w,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                    // icon: Icon(Icons.account_box),
                    prefixIcon: Icon(Icons.account_box),
                  ),
                  onChanged: (value) => setState(() {
                    this.title_input = value;
                  }),
                  keyboardType: TextInputType.visiblePassword,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    // icon: Icon(Icons.account_box),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  onChanged: (value) => setState(() {
                    this.password_input = value;
                  }),
                  keyboardType: TextInputType.visiblePassword,
                ),
              ],
            )),
          ),
        ]),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        Container(
          width: 40.w,
          height: 5.h,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.blueAccent)),
              onPressed: () {
                // openVaultLock(item.vault_password);
                postVault();
              },
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 16.sp),
              )),
        )
      ],
    );
  }

  Widget alertTambahVaultItem() {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      scrollable: true,
      title: Text('Add new vault Item'),
      content: Container(
        width: 80.w,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                    // icon: Icon(Icons.account_box),
                    prefixIcon: Icon(Icons.account_box),
                  ),
                  onChanged: (value) => setState(() {
                    this.title_input = value;
                  }),
                  keyboardType: TextInputType.visiblePassword,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    // icon: Icon(Icons.account_box),
                    prefixIcon: Icon(Icons.account_box),
                  ),
                  onChanged: (value) => setState(() {
                    this.username_input = value;
                  }),
                  keyboardType: TextInputType.visiblePassword,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    // icon: Icon(Icons.account_box),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  onChanged: (value) => setState(() {
                    this.password_input = value;
                  }),
                  keyboardType: TextInputType.visiblePassword,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Comment',
                    // icon: Icon(Icons.account_box),
                    prefixIcon: Icon(Icons.chat_bubble),
                  ),
                  onChanged: (value) => setState(() {
                    this.comment = value;
                  }),
                  keyboardType: TextInputType.visiblePassword,
                ),
              ],
            )),
          ),
        ]),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        Container(
          width: 40.w,
          height: 5.h,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.blueAccent)),
              onPressed: () {
                // openVaultLock(item.vault_password);
                postVaultItem();
              },
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 16.sp),
              )),
        )
      ],
    );
  }

  // final UserData userData;
  @override
  Widget build(BuildContext context) {
    // inspect(this.vaultDetailOpened);
    // returning MaterialApp
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home:
          // scaffold
          Scaffold(
        floatingActionButton: this.selectedIndex == 0
            ? FloatingActionButton(
                onPressed: (() {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return this.vaultDetailOpened == true
                            ? alertTambahVaultItem()
                            : alertTambahVault();
                      });
                })
                // onPressFloatingAction();

                ,
                child: Icon(Icons.add),
                backgroundColor: Colors.amber.shade400,
              )
            : null,
        body: CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          slivers: <Widget>[
            // silverappbar for gradient widget
            SliverAppBar(
              pinned: true,
              expandedHeight: 50,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  // LinearGradient
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    // colors for gradient
                    colors: [
                      Color(0x99ef6b63),
                      Color(0xccef6b63),
                      Color(0xffef6b63),
                      Color(0xffef6b63),
                    ],
                  ),
                ),
              ),
              // title of appbar
              title: Text(
                selectedIndex == 0
                    ? vaultDetailOpened
                        ? "Vault Item"
                        : "Vault"
                    : selectedIndex == 1
                        ? "User Information"
                        : "nul",
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Body Element
                  Expanded(
                    flex: 1,
                    child: Container(
                        child: this.vaultDetailOpened
                            ? VaultDetail(
                                vaultItem: vaultItem,
                                vaultType: 'Cloud',
                                toggleOffVaultDetail: () {
                                  toggleOffVaultDetail();
                                },
                              )
                            : _pages.elementAt(selectedIndex)),
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xffef6b63),
          elevation: 20,
          currentIndex: selectedIndex, //New
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'Vault',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'User',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.dangerous_outlined),
            //   label: 'Nope',
            // ),
          ],
        ),
      ),
    );
  }
}
