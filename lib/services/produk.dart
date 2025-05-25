import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:toko_online/models/produk_model.dart';
import 'package:toko_online/models/response_data_list.dart';
import 'package:toko_online/models/user_login.dart';
import 'package:toko_online/services/url.dart' as url;

class ProdukService {
  Future<ResponseDataList> getProduk() async {
    UserLogin userLogin = UserLogin();
    var user = await userLogin.getUserLogin();
    if (user.status == false) {
      return ResponseDataList(
        status: false,
        message: 'anda belum login / token invalid',
        data: [],
      );
    }

    var uri = Uri.parse(url.Base_Url + "/kasir/getproduk");
    Map<String, String> headers = {
      "Authorization": 'Bearer ${user.token}',
      "Content-Type": "application/json",
    };

    try {
      var getProdukResponse = await http.get(uri, headers: headers);

      if (getProdukResponse.statusCode == 200) {
        var data = json.decode(getProdukResponse.body);
        if (data["status"] == true) {
          List<ProdukModel> produkList = (data["data"] as List)
              .map((r) => ProdukModel.fromJson(r))
              .toList();
          return ResponseDataList(
            status: true,
            message: 'success load data',
            data: produkList,
          );
        } else {
          return ResponseDataList(
            status: false,
            message: 'Failed load data',
            data: [],
          );
        }
      } else {
        return ResponseDataList(
          status: false,
          message: "gagal load produk dengan code error ${getProdukResponse.statusCode}",
          data: [],
        );
      }
    } catch (e) {
      return ResponseDataList(
        status: false,
        message: "Error: ${e.toString()}",
        data: [],
      );
    }
  }

  Future<ResponseDataList> addProduk({
  required String nama,
  required String deskripsi,
  required int harga,
  required String category,
  required File gambar,
}) async {
  UserLogin userLogin = UserLogin();
  var user = await userLogin.getUserLogin();
  if (user.status == false) {
    return ResponseDataList(
      status: false,
      message: 'Anda belum login / token invalid',
      data: [],
    );
  }

  var uri = Uri.parse(url.Base_Url + "/kasir/addproduk");

  var request = http.MultipartRequest("POST", uri)
    ..headers['Authorization'] = 'Bearer ${user.token}'
    ..fields['nama_produk'] = nama
    ..fields['deskripsi'] = deskripsi
    ..fields['harga'] = harga.toString()
    ..fields['category'] = category
    ..files.add(await http.MultipartFile.fromPath('gambar_produk', gambar.path));

  try {
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    var data = json.decode(response.body);
    if (data["status"] == true) {
      return ResponseDataList(status: true, message: 'Berhasil menambah produk', data: []);
    } else {
      return ResponseDataList(status: false, message: data['message'].toString(), data: []);
    }
  } catch (e) {
    return ResponseDataList(status: false, message: "Error: ${e.toString()}", data: []);
  }
}

  Future<ResponseDataList> updateProduk({
    required int id,
    required String nama,
    required String deskripsi,
    required int harga,
    required String category,
    File? image,
  }) async {
    UserLogin userLogin = UserLogin();
    var user = await userLogin.getUserLogin();
    if (user.status == false) {
      return ResponseDataList(
        status: false,
        message: 'Anda belum login / token invalid',
        data: [],
      );
    }

    var uri = Uri.parse(url.Base_Url + "/kasir/update_produk/$id");
    var request = http.MultipartRequest("POST", uri)
      ..headers['Authorization'] = 'Bearer ${user.token}'
      ..fields['nama_produk'] = nama
      ..fields['deskripsi'] = deskripsi
      ..fields['harga'] = harga.toString()
      ..fields['category'] = category;

    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('gambar_produk', image.path));
    }

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      var data = json.decode(response.body);
      return ResponseDataList(
        status: data["status"] ?? false,
        message: data["message"] ?? 'Gagal mengupdate produk',
        data: [],
      );
    } catch (e) {
      return ResponseDataList(
        status: false,
        message: "Error: ${e.toString()}",
        data: [],
      );
    }
  }

  Future<ResponseDataList> deleteProduk(int id) async {
    UserLogin userLogin = UserLogin();
    var user = await userLogin.getUserLogin();
    if (user.status == false) {
      return ResponseDataList(
        status: false,
        message: 'Anda belum login / token invalid',
        data: [],
      );
    }

    var uri = Uri.parse(url.Base_Url + "/kasir/delete_produk/$id");
    Map<String, String> headers = {
      "Authorization": 'Bearer ${user.token}',
      "Content-Type": "application/json",
    };

    try {
      var response = await http.delete(uri, headers: headers);
      var data = json.decode(response.body);
      return ResponseDataList(
        status: data["status"] ?? false,
        message: data["message"] ?? 'Gagal menghapus produk',
        data: [],
      );
    } catch (e) {
      return ResponseDataList(
        status: false,
        message: "Error: ${e.toString()}",
        data: [],
      );
    }
  }

  Future<ResponseDataList> getDetailProduk(int id) async {
    UserLogin userLogin = UserLogin();
    var user = await userLogin.getUserLogin();
    if (user.status == false) {
      return ResponseDataList(
        status: false,
        message: 'Anda belum login / token invalid',
        data: [],
      );
    }

    var uri = Uri.parse(url.Base_Url + "/kasir/get_detail_produk/$id");
    Map<String, String> headers = {
      "Authorization": 'Bearer ${user.token}',
      "Content-Type": "application/json",
    };

    try {
      var response = await http.get(uri, headers: headers);
      var data = json.decode(response.body);
      if (data["status"] == true && data["data"] != null) {
        return ResponseDataList(
          status: true,
          message: data["message"],
          data: [ProdukModel.fromJson(data["data"])],
        );
      } else {
        return ResponseDataList(
          status: false,
          message: data["message"] ?? 'Gagal memuat detail produk',
          data: [],
        );
      }
    } catch (e) {
      return ResponseDataList(
        status: false,
        message: "Error: ${e.toString()}",
        data: [],
      );
    }
  }
}