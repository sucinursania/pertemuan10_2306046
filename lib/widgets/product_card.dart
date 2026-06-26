import 'package:flutter/material.dart';
import 'package:pertemuan10_2306046/models/product_model.dart';
import 'package:pertemuan10_2306046/pages/product_detail_page.dart';
import 'dart:convert';

class ProductCard extends StatelessWidget {
  //  variabel parameter
  final ProductModel product;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  // constructor
  const ProductCard({
    super.key,
    required this.product,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: .circular(15)),
      child: ListTile(
        contentPadding: EdgeInsets.all(15),
        title: Text(product.name, style: TextStyle(fontWeight: .bold)),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(product: product),
          ),
        ),

        subtitle: Column(
          crossAxisAlignment: .start,
          children: [
            product.image.isNotEmpty
                ? Image.memory(
                    base64Decode(product.image),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  )
                : const Icon(Icons.image, size: 120),
                Text("Rp ${product.price}"),
                const SizedBox(height: 5),
          ],
        ),
        leading: onEdit != null ? IconButton(
          icon: Icon(Icons.edit, color: Colors.orange),
          onPressed: onEdit,
        ): null,
        trailing: onDelete != null ? IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ): null,
      ),
    );
  }
}
