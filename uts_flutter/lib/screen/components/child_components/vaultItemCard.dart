import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uts_flutter/api/api.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VaultItemCard extends StatefulWidget {
  final vaultData;
  final vaultId;

  const VaultItemCard(
      {super.key, required this.vaultData, required this.vaultId});

  @override
  State<VaultItemCard> createState() => _VaultItemCardState();
}

class _VaultItemCardState extends State<VaultItemCard> {
  @override
  Widget build(BuildContext context) {
    final vaultItemId = widget.vaultData.id;
    late String password_input = widget.vaultData.password;
    late String username_input = widget.vaultData.username;
    late String comment_input = widget.vaultData.comment;
    Api _api = Api();

    delVaultItem(idItem) async {
      bool response = await _api.delVaultItem(widget.vaultId, idItem);
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

    updateVaultItem() async {
      if (username_input != "" || password_input != "") {
        bool response = await _api.putVaultItem(widget.vaultId, vaultItemId,
            username_input, password_input, comment_input);
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
          msg: "Isi dulu datanya dong",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
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
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent)),
                onPressed: () {
                  delVaultItem(vaultItemId);
                },
                child: Text('Ya Hapus')),
          ),
          Container(
            width: 40.w,
            height: 5.h,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueAccent)),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
                child: Text('Batal')),
          )
        ],
      );
    }

    Widget alertEdit() {
      return AlertDialog(
        insetPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        scrollable: true,
        title: Text(widget.vaultData.title),
        content: Container(
          width: 80.w,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Form(
                  child: Column(
                children: [
                  TextFormField(
                    initialValue: username_input,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      // icon: Icon(Icons.account_box),
                      prefixIcon: Icon(Icons.account_box),
                    ),
                    onChanged: (value) => setState(() {
                      username_input = value;
                    }),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  TextFormField(
                    initialValue: password_input,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      // icon: Icon(Icons.account_box),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    onChanged: (value) => setState(() {
                      password_input = value;
                    }),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  TextFormField(
                    initialValue: comment_input,
                    decoration: InputDecoration(
                      labelText: 'Comment',
                      // icon: Icon(Icons.account_box),
                      prefixIcon: Icon(Icons.chat_bubble),
                    ),
                    onChanged: (value) => setState(() {
                      comment_input = value;
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
                  updateVaultItem();
                },
                child: Text('Submit')),
          )
        ],
      );
    }

    // inspect(vaultData);
    return Container(
        width: 90.w,
        // height: 10.5.h,

        padding: const EdgeInsets.all(10.0),
        child: Row(children: [
          Container(
            width: 84.w,
            padding: EdgeInsets.symmetric(vertical: 15.sp),
            child: Column(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  this.widget.vaultData.title,
                  style: TextStyle(color: Colors.black87, fontSize: 18.sp),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  this.widget.vaultData.comment,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Username : " + this.widget.vaultData.username,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 17.sp,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Password : " + this.widget.vaultData.password,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 17.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Center(
                child: Row(
                  children: [
                    SizedBox(
                      width: 1.w,
                    ),
                    Container(
                      width: 40.w,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blueAccent)),
                        child: Text("Edit"),
                        onPressed: (() {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alertEdit();
                              });
                        }),
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Container(
                      width: 40.w,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.redAccent)),
                        child: Text("Delete"),
                        onPressed: (() {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alertDelete();
                              });
                        }),
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ]),
        color: Colors.white70);
  }
}
