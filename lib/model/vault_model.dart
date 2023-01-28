import 'dart:ffi';

import 'package:uts_flutter/model/vault_item_model.dart';

class VaultModel {
  final String vault_name;
  final String vault_password;
  final String vault_img;
  final String createdAt;
  final String id;
  final List vault_item;
  const VaultModel({
    required this.vault_name,
    required this.vault_password,
    required this.vault_img,
    required this.createdAt,
    required this.id,
    required this.vault_item,
  });

  factory VaultModel.fromJson(Map<String, dynamic> json) {
    return VaultModel(
      vault_name: json['vault_name'],
      vault_password: json['vault_password'],
      vault_img: json['vault_img'],
      createdAt: json['createdAt'],
      id: json['id'],
      vault_item: json['vault_item'],
    );
  }

  Map<String, dynamic> toJson() => {
        'vault_name': vault_name,
        'vault_password': vault_password,
        'vault_img': vault_img,
        'createdAt': createdAt,
        'id': id,
        'vault_item': vault_item,
      };
}
