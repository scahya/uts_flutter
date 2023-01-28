import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uts_flutter/api/model.dart';
import 'package:http/http.dart' as http;
import 'package:uts_flutter/model/vault_item_model.dart';
import 'package:uts_flutter/model/vault_model.dart';

class Api {
  final _baseURL = 'https://63b639b21907f863aaf0ca0e.mockapi.io/bcah';

  // Future reqRegis(
  //     String name, String password, String dateBirth, String email) async {
  //   try {
  //     final response = await http.post(Uri.parse(_baseURL + '/regis'), body: {
  //       'email': email,
  //       'name': name,
  //       'password': password,
  //       'dateBirth': dateBirth
  //     });
  //     if (response.statusCode == 201) {
  //       return response;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future getVault() async {
    final response = await http.get(Uri.parse(_baseURL + '/vault'));
    if (response.statusCode == 200) {
      // inspect(response.body);
      // Iterable it = jsonDecode(response.body); //null
      // List<VaultModel> item =
      //     it.map((e) => VaultModel.fromJson(e)).toList(); //null
      // print(it);
      // inspect(item);
      Iterable itemJson = json.decode(response.body);
      // final item = VaultModel.fromJson(itemJson);
      List<VaultModel> item =
          itemJson.map((e) => VaultModel.fromJson(e)).toList();
      // inspect(itemJson);
      return item;
    }
  }

  Future postVault(String vaultName, String vaultPassword) async {
    final response = await http.post(Uri.parse(_baseURL + '/vault'),
        body: jsonEncode(<String, String>{
          'vault_name': vaultName,
          'vault_password': vaultPassword,
        }));
    if (response.statusCode == 201) {
      return true;
    } else {
      // inspect(response);
      return false;
    }
  }

  Future delVault(String id) async {
    final response = await http.delete(Uri.parse(_baseURL + '/vault/' + id));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future getVaultItem(String id) async {
    final response =
        await http.get(Uri.parse(_baseURL + '/vault/' + id + '/item'));
    if (response.statusCode == 200) {
      // inspect(response.body);
      // Iterable it = jsonDecode(response.body); //null
      // List<VaultModel> item =
      //     it.map((e) => VaultModel.fromJson(e)).toList(); //null
      // print(it);
      // inspect(item);
      Iterable itemJson = json.decode(response.body);
      // final item = VaultModel.fromJson(itemJson);
      List<VaultItemModel> item =
          itemJson.map((e) => VaultItemModel.fromJson(e)).toList();
      // inspect(itemJson);
      return item;
    }
  }

  Future delVaultItem(String id, String id_item) async {
    final response = await http
        .delete(Uri.parse(_baseURL + '/vault/' + id + "/item/" + id_item));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future putVaultItem(String id, String idItem, String username,
      String password, String comment) async {
    try {
      final response = await http
          .put(Uri.parse(_baseURL + '/vault/' + id + "/item/" + idItem), body: {
        'username': username,
        'password': password,
        'comment': comment
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print((e.toString()));
    }
  }

  Future postVaultItem(String id, String title, String username,
      String password, String comment) async {
    final response =
        await http.post(Uri.parse(_baseURL + '/vault/' + id + '/item'),
            body: jsonEncode(<String, String>{
              'title': title,
              'username': username,
              'password': password,
              'comment': comment,
            }));

    if (response.statusCode == 201) {
      return true;
    } else {
      // inspect(response);
      return false;
    }
  }

  Future postData(String name, String address) async {
    try {
      final response = await http.post(Uri.parse(_baseURL + '/mahasiswa'),
          body: {"name": name, "address": address});
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future putData(int id, String name, String address) async {
    try {
      final response = await http.put(
          Uri.parse(_baseURL + '/mahasiswa/' + id.toString()),
          body: {'name': name, 'address': address});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print((e.toString()));
    }
  }

  Future deleteData(String id) async {
    try {
      final response =
          await http.delete(Uri.parse(_baseURL + '/mahasiswa/' + id));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
