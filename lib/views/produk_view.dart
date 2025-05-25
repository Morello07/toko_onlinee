import 'package:flutter/material.dart';
import 'package:toko_online/models/produk_model.dart';
import 'package:toko_online/services/produk.dart';
import 'package:toko_online/widgets/bottom_nav.dart';
import 'package:toko_online/views/add_produk_view.dart';
import 'package:toko_online/views/update_produk_view.dart';

class ProdukView extends StatefulWidget {
  const ProdukView({super.key});

  @override
  State<ProdukView> createState() => _ProdukViewState();
}

class _ProdukViewState extends State<ProdukView> {
  ProdukService produkService = ProdukService();
  List<ProdukModel> produkList = [];
  bool isLoading = true;

  void getProdukData() async {
    var response = await produkService.getProduk();
    setState(() {
      if (response.status && response.data != null) {
        produkList = response.data as List<ProdukModel>;
      }
      isLoading = false;
    });
  }

  void _navigateToAddProduct() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddProdukView()),
    );
    if (result == true) {
      getProdukData(); // Refresh the product list
    }
  }

  void _editProduk(ProdukModel produk) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProdukView(produk: produk),
      ),
    );

    if (result == true) {
      setState(() {
        isLoading = true;
      });
      getProdukData();
    }
  }

  void _deleteProduk(ProdukModel produk) async {
    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus ${produk.nama}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    ) ?? false;

    if (confirm) {
      setState(() {
        isLoading = true;
      });

      var response = await produkService.deleteProduk(produk.id!);
      setState(() {
        isLoading = false;
      });

      if (!mounted) return;

      if (response.status) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
        getProdukData();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getProdukData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produk"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToAddProduct,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : produkList.isEmpty
              ? const Center(child: Text("Tidak ada produk"))
              : ListView.builder(
                  itemCount: produkList.length,
                  itemBuilder: (context, index) {
                    var produk = produkList[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: produk.gambar != null
                            ? Image.network(
                                produk.gambar!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.image),
                              )
                            : const Icon(Icons.image),
                        title: Text(produk.nama),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(produk.deskripsi),
                            Text(
                              'Rp ${produk.harga.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _editProduk(produk),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteProduk(produk),
                              color: Colors.red,
                            ),
                          ],
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                ),
      bottomNavigationBar: const BottomNav(1),
    );
  }
}