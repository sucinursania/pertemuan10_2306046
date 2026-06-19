import 'package:flutter/material.dart';
import 'package:pertemuan10_2306046/models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  // membuat varibel utk menampilkan data produk yg dipilih
  final ProductModel product;

  // constructor
  const ProductDetailPage({super.key, required this.product});

  // widget builder
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Produk")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: .bold),
            ),
            SizedBox(height: 10,),
            Text("Rp ${{product.price}}"),
            SizedBox(height: 10,),
            Text(product.description)
          ],
        ),
      ),
    );
  }
}
