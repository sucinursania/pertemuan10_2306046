import 'package:flutter/material.dart';
import 'package:pertemuan10_2306046/models/product_model.dart';
import 'package:pertemuan10_2306046/pages/product_detail_page.dart';
import 'package:pertemuan10_2306046/widgets/product_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // variabel utama
  List<ProductModel> products = [];
  // membuat method loadproducts untuk menampilkan daftar product
  Future<void> loadProducts() async {
    final res = await SharedPreferences.getInstance();
    List<String> productList = res.getStringList('products') ?? [];
    setState(() {
      products = productList
          .map((item) => ProductModel.fromJson(item))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  // methode saveprododuct untuk menyimpan product
  Future<void> saveProduct() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> productList = products.map((item) => item.toJson()).toList();
    await prefs.setStringList('products', productList);
  }

  // method addproduct untuk menambah product
  Future<void> addProduct(ProductModel product) async {
    setState(() {
      products.add(product);
    });
    await saveProduct();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Produk berhasil ditambahkan")),
    );
  }

  // method update
  Future<void> updateProduct(int index, ProductModel product) async {
    setState(() {
      products[index] = product;
    });
    await saveProduct();
  }

  // methode delete product
  Future<void> deleteProduct(int index) async {
    setState(() {
      products.removeAt(index);
    });
    await saveProduct();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Produk berhasil dihapus")));
  }

  // showform
  void showform({ProductModel? product, int? index}) {
    TextEditingController nameController = TextEditingController(
      text: product?.name ?? "",
    );
    TextEditingController descriptionController = TextEditingController(
      text: product?.description ?? "",
    );
    TextEditingController priceController = TextEditingController(
      text: product?.price.toString() ?? "",
    );

    final formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(product == null ? "Tambah Produk" : "Edit Produk"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: .min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Nama"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Nama produk wajib diisi";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Deskripsi"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Deskripsi wajib diisi";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: "Harga"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Harga wajib diisi";
                  }
                  if (int.tryParse(value) == null) {
                    return "Harga harus berupa angka";
                  }
                  if (int.parse(value) <= 0) {
                    return "Harga harus lebih dari 0";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) {
                return;
              }
              final newProduct = ProductModel(
                name: nameController.text,
                description: descriptionController.text,
                price: int.parse(priceController.text),
              );

              if (product == null) {
                addProduct(newProduct);
              } else {
                updateProduct(index!, newProduct);
              }
              Navigator.pop(context);
            },
            child: Text(product == null ? "Simpan" : "Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Produk",
          style: TextStyle(color: Colors.white, fontWeight: .bold),
        ),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: products.isEmpty
                  ? Center(child: Text("Belum ada produk"))
                  : ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductCard(
                          product: product,
                          onDelete: () => deleteProduct(index),
                          onEdit: () => 
                            showform(product: product, index: index),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showform,
        child: Icon(Icons.add),
      ),
    );
  }
}
