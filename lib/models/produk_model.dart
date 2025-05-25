class ProdukModel {
  final int? id;
  final String nama;
  final String deskripsi;
  final int harga;
  final String category;
  final String? gambar;

  ProdukModel({
    this.id,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.category,
    this.gambar,
  });

  factory ProdukModel.fromJson(Map<String, dynamic> json) {
    return ProdukModel(
      id: json['id'],
      nama: json['nama'],
      deskripsi: json['deskripsi'],
      harga: int.parse(json['harga'].toString()),
      category: json['category'] ?? '',
      gambar: json['gambar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'deskripsi': deskripsi,
      'harga': harga,
      'category': category,
      'gambar': gambar,
    };
  }
}