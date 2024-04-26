import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lakukan/pages/addData.dart';
import 'package:lakukan/pages/detail.dart';
import 'package:lakukan/pages/intro.dart';
import 'package:lakukan/pages/search.dart';
import 'package:lakukan/theme/style.dart';
import '../model/product.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();
  final Dio dio = Dio();

  List<Product> products = [];
  List<String> categories = [];

  int totalProduct = 1000;
  bool isLoading = false;

  final List<String> imagePaths = [
    'lib/asset/images/banner.jpg',
    'lib/asset/images/off1.jpg',
    'lib/asset/images/off2.jpg',
  ];

  @override
  void initState() {
    super.initState();
    getProducts();
    getCategories();
    scrollController.addListener(loadMoreData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: AppColor.primaryExtraSoft,
            ),
            child: IconButton(
              icon: Icon(Icons.search, color: AppColor.secondary),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: AppColor.primaryExtraSoft,
            ),
            child: IconButton(
              icon: Icon(Icons.logout_rounded, color: AppColor.secondary),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const IntroPage()),
                );
              },
            ),
          ),
          const SizedBox(width: 18),
        ],
        iconTheme: IconThemeData(
          color: AppColor.secondary,
        ),
        centerTitle: false,
        elevation: 0,
        title: Text(
          "Storein",
          style: TextStyle(
            fontSize: 30,
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.7,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  clipBehavior: Clip.hardEdge,
                  height: 180.0,
                  enlargeCenterPage: false,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  enableInfiniteScroll: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  viewportFraction: 1,
                  scrollDirection: Axis.horizontal,
                ),
                items: imagePaths.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kategori",
                    style: TextStyle(
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: AppColor.secondary,
                    ),
                  ),
                  Text(
                    "Lihat Semua",
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15,),
              SizedBox(
                height: 100, // Adjust the height of the category list container as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColor.primaryExtraSoft,
                            radius: 30,
                            child: const Icon(Icons.category),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            categories[index].length <= 7
                                ? categories[index]
                                : '${categories[index].substring(0, 7)}...',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'inter',
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rekomendasi",
                    style: TextStyle(
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: AppColor.secondary,
                    ),
                  ),
                  Text(
                    "Lihat semua",
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15,),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 7.0 / 10.0,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            DetailPage(productId: product.id!)),
                      );
                    },
                    child: Card(
                      color: AppColor.primaryExtraSoft,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                      image: NetworkImage(product.thumbnail!),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 1, top: 10),
                                child: Text(
                                  product.title!,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'inter',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 1, top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$${product.price.toString()}",
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.success
                                      ),
                                    ),
                                    Text(
                                      "⭐ ${product.discountPercentage.toString() ?? ''}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.secondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
                isLoading
                    ? const Padding(
                  padding: EdgeInsets.all(18),
                  child: SpinKitFadingCircle(
                    color: Colors.blue, // Customize the loading indicator color
                    size: 40,
                  ),
                )
                    : const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Center(
                        child: Text(
                          '© Guntur Darmawan', // Text to display when not loading
                          style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddProductPage();
        },
        backgroundColor: AppColor.primary,
        child: const Icon(Icons.add,color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void loadMoreData() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && products.length < totalProduct) {
      getProducts();
    }
  }

  Future<void> getProducts() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await dio.get(
          "https://dummyjson.com/products?limit=10&skip=${products
              .length}&select=title,price,thumbnail,discountPercentage");
      final List data = response.data["products"];
      final List<Product> newProducts =
      data.map((p) => Product.fromJson(p)).toList();
      setState(() {
        isLoading = false;
        totalProduct = response.data['total'];
        products.addAll(newProducts);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getCategories() async {
    try {
      const String url = "https://dummyjson.com/products/categories";

      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List<dynamic> categoriesJson = response.data as List<dynamic>;

        List<String> categoriesList = categoriesJson.map((category) => category.toString()).toList();
        setState(() {
          categories = categoriesList;
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      throw Exception('Failed to load categories');
    }
  }

  void _navigateToAddProductPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddDataPage()),
    );
  }

}


