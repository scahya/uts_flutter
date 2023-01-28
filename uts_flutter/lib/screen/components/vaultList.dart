import 'dart:ffi';

import 'package:flat_list/flat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uts_flutter/model/vault_model.dart';
import 'package:uts_flutter/screen/components/child_components/vaultCard.dart';
import '../../api/api.dart';
import 'dart:developer';
import 'package:responsive_sizer/responsive_sizer.dart';

class VaultList extends StatefulWidget {
  final toggleOnVaultDetail;
  const VaultList({super.key, required this.toggleOnVaultDetail});
  @override
  _VaultState createState() => _VaultState();
}

class _VaultState extends State<VaultList> {
  bool local = false;
  var Item;
  // var olala;
  // bool isHidden = true;
  late String password_input = "";

  @override
  void initState() {
    getData();
    init();
    super.initState();
  }

  List<VaultModel> vaultList = [];
  List<VaultModel> vaultListLocal = [];
  Api _api = Api();

  Future getData() async {
    var olala = await _api.getVault();
    setState(() {
      vaultList = List<VaultModel>.from(olala);
    });

    // setState(() {});
    // getIns();
  }

  // getIns() {
  //   inspect(olala);
  //   inspect(vaultList);
  // }

  Future init() async {}

  Widget cloudBtn() {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
      ),
      height: 40,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)))),
            backgroundColor: MaterialStateProperty.all(this.local
                ? Color.fromARGB(255, 245, 180, 177)
                : Color.fromARGB(255, 250, 121, 114))),
        child: Text('Cloud Vault'),
        onPressed: () {
          getData();
          setState(() {
            this.local = false;
          });
        },
      ),
    );
  }

  Widget localBtn() {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
      ),
      height: 40,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)))),
            backgroundColor: MaterialStateProperty.all(this.local
                ? Color.fromARGB(255, 250, 121, 114)
                : Color.fromARGB(255, 245, 180, 177))),
        child: Text('Local'),
        onPressed: () {
          setState(() {
            this.local = true;
          });
        },
      ),
    );
  }

  openVaultLock(item) {
    if (item.vault_password.toString() == this.password_input) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      widget.toggleOnVaultDetail(item);
      // return Fluttertoast.showToast(
      //   msg: "Boleh",
      //   toastLength: Toast.LENGTH_LONG,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.redAccent,
      //   textColor: Colors.white,
      //   fontSize: 16.0,
      // );
    } else {
      return Fluttertoast.showToast(
        msg: "Salah bro",
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  deleteVault(item) async {
    if (password_input == item.vault_password) {
      bool response = await _api.delVault(item.id);
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
    } else {
      return Fluttertoast.showToast(
        msg: "Password salah bro",
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Widget longPress(item) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      scrollable: true,
      title: Text('Delete ' + item.vault_name.toString() + '?'),
      content: Container(
        width: 80.w,
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Type : ' + (this.local == false ? 'Cloud' : 'Local'),
            ),
          ),
          Icon(
            Icons.warning_amber,
            color: Colors.redAccent,
            size: 40.sp,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              // icon: Icon(Icons.account_box),
              prefixIcon: Icon(
                Icons.lock,
                // color: Color(0xffef6b63),
              ),
            ),
            onChanged: (value) => setState(() {
              password_input = value;
            }),
            keyboardType: TextInputType.visiblePassword,
          ),
        ]),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        SizedBox(
          width: 40.w,
          height: 5.h,
          child: ElevatedButton(
              onPressed: () {
                // openVaultLock(item.vault_password);
                deleteVault(item);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
              ),
              child: Text(
                'Yes',
                style: TextStyle(fontSize: 16.sp),
              )),
        ),
        SizedBox(
          width: 40.w,
          height: 5.h,
          child: ElevatedButton(
              onPressed: () {
                // openVaultLock(item.vault_password);
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 16.sp),
              )),
        )
      ],
    );
  }

  Widget normalPress(item) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      scrollable: true,
      title: Text(item.vault_name),
      content: Container(
        width: 80.w,
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Type : ' + (this.local == false ? 'Cloud' : 'Local'),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(item.vault_password.toString()),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Form(
                child: Column(
              children: [
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      // color: Color(0xffef6b63),
                    ),
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
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Container(
          width: 50.w,
          height: 5.h,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.blueAccent)),
              onPressed: () {
                openVaultLock(item);
              },
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 16.sp),
              )),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 5.w),

        // color: Colors.amberAccent[400],
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: cloudBtn(),
                ),
                Expanded(
                  child: localBtn(),
                ),
              ],
            ),
            Container(
              height: 75.h,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
                color: Color(0xffecf0f1),
              ),
              child: FlatList(
                  onRefresh: () async {
                    getData();
                  },
                  refreshIndicatorColor: Color(0xffef6b63),
                  data: local ? vaultListLocal : vaultList,
                  buildItem: (item, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 0.5.h),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade50,
                              padding: EdgeInsets.symmetric(vertical: 0.h)),
                          onPressed: (() {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return normalPress(item);
                                });
                          }),
                          onLongPress: (() {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return longPress(item);
                                });
                          }),
                          child: VaultCard(
                            vaultData: item,
                            vaultType: this.local == false ? 'Cloud' : 'Local',
                          )),
                    );
                  },
                  listEmptyWidget: Container(
                    width: 30.h,
                    height: 60.h,
                    child: Center(
                      // child: Image.network(
                      //     'https://i.giphy.com/media/jAYUbVXgESSti/200.gif'),
                      child: Image.asset("assets/images/loading_flut.gif"),
                    ),
                  )),
            ),
          ],
        ));

    // TODO: implement build
    throw UnimplementedError();
  }
}
