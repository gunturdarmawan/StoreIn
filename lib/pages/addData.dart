import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:lakukan/pages/home.dart';

class AddDataPage extends StatefulWidget {
  const AddDataPage({Key? key}) : super(key: key);

  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _thumbnailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final Dio _dio = Dio();

  void _addProduct() async {
    try {
      // Send a POST request to the API endpoint
      await _dio.post(
        'https://dummyjson.com/products/add',
        data: {
          'title': _titleController.text,
          'price': _priceController.text,
          'thumbnail': _thumbnailController.text,
          'description': _descriptionController.text,
        },
      );

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Produk Berhasil ditambahkan'),
          backgroundColor: Colors.green,
        ),
      );

      if (!context.mounted) return;
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
        return const HomePage();
      }, ), (route) => false,);
    } catch (e) {
      // Show an error message if the request fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menambahkan produk: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambahkan Produk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Harga',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _thumbnailController,
              decoration: const InputDecoration(
                labelText: 'Thumbnail URL',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addProduct,
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
