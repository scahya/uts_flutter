import 'dart:async';

import 'package:flat_list/flat_list.dart';
import 'package:flutter/material.dart';
import 'package:uts_flutter/model/vault_item_model.dart';
import 'package:uts_flutter/screen/components/child_components/vaultItemCard.dart';
import '../../api/api.dart';
import 'dart:developer';
import 'package:uts_flutter/model/vault_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VaultDetail extends StatefulWidget {
  final vaultItem;
  final vaultType;
  final toggleOffVaultDetail;
  const VaultDetail(
      {super.key,
      required this.vaultItem,
      required this.vaultType,
      required this.toggleOffVaultDetail});
  @override
  _VaultState createState() => _VaultState();
}

class _VaultState extends State<VaultDetail> {
  Api _api = Api();
  // var olala;
  List<VaultItemModel> vaultItemList = [];
  bool refresh = false;
  @override
  void initState() {
    getData();
    init();
    super.initState();
  }

  Future getData() async {
    var olala = await _api.getVaultItem(widget.vaultItem.id);

    setState(() {
      vaultItemList = List<VaultItemModel>.from(olala);
    });
    getIns();
  }

  getIns() {
    // inspect(olala);
    print('asui');
    inspect(vaultItemList);
  }

  refreshed() {
    getData();
    Timer(Duration(seconds: 3), () {
      setState(() {
        this.refresh = !refresh;
      });
    });
  }

  Future init() async {}
  @override
  Widget build(BuildContext context) {
    final vaultItem = widget.vaultItem;
    final vaultType = widget.vaultType;
    // inspect(vaultItem.vault_item);
    // final List<VaultItemModel> ITEM =
    //     List<VaultItemModel>.from(vaultItem.vault_item);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          SizedBox(
              child: Row(
            children: [
              Container(
                width: 30.sp,
                height: 30.sp,
                color: Colors.grey[200],
                child: ElevatedButton(
                  onPressed: () {
                    print('0');
                    widget.toggleOffVaultDetail();
                  },
                  child: Icon(Icons.arrow_back),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.white))),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueAccent),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Container(
                width: 42.w,
                child: Column(
                  children: [
                    Text(
                      vaultItem.vault_name,
                      style: TextStyle(
                          color: Color(0xffef6b63),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'type : ' + vaultType,
                      style: TextStyle(
                        // color: Color(0xffef6b63),
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Container(
                width: 30.sp,
                height: 30.sp,
                color: Colors.grey[200],
                child: ElevatedButton(
                  onPressed: () {
                    // print('0');
                    // widget.toggleOffVaultDetail();
                    refreshed();
                    // setState(() {
                    //   this.refresh = !refresh;
                    // });
                  },
                  child: Icon(Icons.refresh),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.white))),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueAccent),
                  ),
                ),
              ),
            ],
          )),
          Container(
            height: 75.h,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xffecf0f1),
            ),
            child: FlatList(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 2));
                  getData();
                },
                data: vaultItemList,
                listEmptyWidget: Container(
                  width: 30.h,
                  height: 60.h,
                  child: Center(
                    // child: Image.network(
                    //     'https://i.giphy.com/media/jAYUbVXgESSti/200.gif'),
                    child: Image.asset("assets/images/loading_flut.gif"),
                  ),
                ),
                buildItem: (item, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 0.5.h),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade50,
                            padding: EdgeInsets.symmetric(vertical: 0.h)),
                        onPressed: () {},
                        child: VaultItemCard(
                          vaultData: item,
                          vaultId: widget.vaultItem.id,
                        )),
                  );
                }),
          )
        ],
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
