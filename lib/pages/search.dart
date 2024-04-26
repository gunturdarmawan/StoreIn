import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:lakukan/theme/style.dart';
import '../model/product.dart';
import 'detail.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final Dio _dio = Dio();
  List<Product> _searchResults = [];

  void _searchProducts(String query) async {
    try {
      // Clear previous search results
      setState(() {
        _searchResults.clear();
      });

      // Perform search using API
      final response = await _dio.get('https://dummyjson.com/products/search?q=$query');
      final List<dynamic> data = response.data["products"];

      // Map the response data to Product objects
      List<Product> products = data.map((p) => Product.fromJson(p)).toList();

      // Update the search results
      setState(() {
        _searchResults = products;
      });
    } catch (e) {
      print('Error searching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Search Products'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                fillColor: CupertinoColors.activeBlue,
                labelText: 'Search',
                hintText: 'Cari produk',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                _searchProducts(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final Product product = _searchResults[index];
                return ListTile(
                  title: Text(product.title!),
                  subtitle: Text('\$${product.price}'),
                  leading: Image(
                    width: 150,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      product.thumbnail!,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          DetailPage(productId: product.id!)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
