import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer';
import 'package:responsive_sizer/responsive_sizer.dart';

class VaultCard extends StatelessWidget {
  final vaultData;
  final vaultType;
  const VaultCard(
      {super.key, required this.vaultData, required this.vaultType});

  @override
  Widget build(BuildContext context) {
    // inspect(vaultData);
    return Container(
        width: 90.w,
        // height: 10.5.h,
        padding: const EdgeInsets.all(10.0),
        child: Row(children: [
          Container(
            width: 65.w,
            padding: EdgeInsets.symmetric(vertical: 15.sp),
            child: Column(children: [
              Text(
                this.vaultData.vault_name,
                style: TextStyle(color: Colors.black87, fontSize: 17.sp),
              ),
              SizedBox(height: 15),
              Text(
                this.vaultData.vault_item.length.toString() + ' Item',
                style: TextStyle(color: Colors.black87),
              ),
              Text(
                'Locked',
                style: TextStyle(color: Colors.black87),
              ),
              Icon(
                Icons.lock,
                color: Color(0xffef6b63),
              )
            ]),
          ),
          SizedBox(
              width: 30.sp,
              height: 30.sp,
              child: CircleAvatar(
                backgroundImage: NetworkImage(vaultData.vault_img),
              )),
        ]),
        color: Colors.white70);
  }
}
