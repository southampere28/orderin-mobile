import 'dart:convert';

import 'package:orderez/model/Product.dart';

Transaksi transaksiFromJson(String str) => Transaksi.fromJson(json.decode(str));

String transaksiToJson(Transaksi data) => json.encode(data.toJson());

class Transaksi {
    int kodeTransaksi;
    String nama;
    String status;
    int jumlah;
    int total;
    DateTime createdAt;
    DateTime updatedAt;
    List<Detail> details;

    Transaksi({
        required this.kodeTransaksi,
        required this.nama,
        required this.status,
        required this.jumlah,
        required this.total,
        required this.createdAt,
        required this.updatedAt,
        required this.details,
    });

    factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
        kodeTransaksi: json["kode_transaksi"],
        nama: json["nama"],
        status: json["status"],
        jumlah: json["jumlah"],
        total: json["total"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "kode_transaksi": kodeTransaksi,
        "nama": nama,
        "status": status,
        "jumlah": jumlah,
        "total": total,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
    };

}

class Detail {
    int kodeTransaksi;
    int kodeProduct;
    int jumlah;
    int harga;
    int total;
    Product product;

    Detail({
        required this.kodeTransaksi,
        required this.kodeProduct,
        required this.jumlah,
        required this.harga,
        required this.total,
        required this.product,
    });

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        kodeTransaksi: json["kode_transaksi"],
        kodeProduct: json["kode_product"],
        jumlah: json["jumlah"],
        harga: json["harga"],
        total: json["total"],
        product: Product.fromJson(json["product"]),
    );

    Map<String, dynamic> toJson() => {
        "kode_transaksi": kodeTransaksi,
        "kode_product": kodeProduct,
        "jumlah": jumlah,
        "harga": harga,
        "total": total,
        "product": product.toJson(),
    };

}