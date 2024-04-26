import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:carousel_slider/carousel_slider.dart';


import '../model/product.dart';
import '../theme/style.dart';

class DetailPage extends StatefulWidget {
  final int productId;

  const DetailPage({Key? key, required this.productId}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<Product> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = _fetchProduct(widget.productId);
    print(_productFuture.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Product Detail'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Product>(
          future: _productFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final product = snapshot.data;
              if (product != null) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          clipBehavior: Clip.hardEdge,
                          height: 210.0,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration: const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: false,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: product.images!.map((image) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                                child:  ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${product.price ?? ''}',
                            style: TextStyle(
                              fontSize: 30,
                              color: AppColor.success,
                              fontFamily: 'inter',
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.black
                            ),
                            child: Text(
                              '\OFF ${product.discountPercentage ?? ''}\%',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'inter',
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.title ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        "Detail produk",
                        style: TextStyle(
                          fontFamily: 'inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: AppColor.secondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Rating: ⭐ ${product.rating ?? ''}',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black54),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Brand: ${product.brand!}',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black54),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Stock: ${product.stock ?? ''}',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black54),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        "Deskripsi produk",
                        style: TextStyle(
                          fontFamily: 'inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: AppColor.secondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.description ?? '',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black54),
                      ),
                      const SizedBox(height: 22),
                       Row(
                        children: [
                          Container(
                            height: 58,
                            width: 58,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(width: 2, color: AppColor.primary),
                            ),
                            child: Icon(Icons.favorite, color: AppColor.primary),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: 58,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                color: AppColor.primary,
                              ),
                              child: const Text(
                                '+ Keranjang',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'inter',
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text('Product not found'),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Future<Product> _fetchProduct(int productId) async {
    final String apiUrl = 'https://dummyjson.com/products/$productId';
    final response = await Dio().get(apiUrl);
    return Product.fromJson(response.data);
  }
}


