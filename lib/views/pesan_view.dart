import 'package:flutter/material.dart';
import 'package:toko_online/models/produk_model.dart';
import 'package:toko_online/services/produk.dart';
import 'package:toko_online/widgets/bottom_nav.dart';

class PesanView extends StatefulWidget {
  const PesanView({super.key});
  @override
  State<PesanView> createState() => _PesanViewState();
}

class _PesanViewState extends State<PesanView> {
  final ProdukService _produkService = ProdukService();
  List<ProdukModel> _produkList = [];
  Map<int, int> _cart = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final response = await _produkService.getProduk();
    setState(() {
      _produkList = response.status ? (response.data as List<ProdukModel>) : [];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesan Produk"),
        backgroundColor: Colors.green,
        actions: [_buildCartButton()],
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : _buildProductGrid(),
      bottomNavigationBar: const BottomNav(1),
    );
  }

  Widget _buildCartButton() {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {/* TODO: Implement cart view */},
        ),
        if (_cart.isNotEmpty)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
              child: Text(
                _cart.values.reduce((a, b) => a + b).toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _produkList.length,
      itemBuilder: (context, index) => _buildProductCard(_produkList[index]),
    );
  }

  Widget _buildProductCard(ProdukModel produk) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: produk.gambar != null
                ? Image.network(produk.gambar!, fit: BoxFit.cover)
                : const Icon(Icons.image, size: 100),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(produk.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('Rp ${produk.harga.toStringAsFixed(2)}', 
                     style: const TextStyle(color: Colors.green)),
                ElevatedButton(
                  onPressed: () => setState(() => 
                    _cart[produk.id!] = (_cart[produk.id!] ?? 0) + 1),
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
