import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skin_care/features/home/model/all_products.dart';
import 'package:skin_care/features/home/model/favourite_list_model.dart';
import 'package:skin_care/main.dart';

class ProductDetailsScreen extends StatelessWidget {
  // static String id = "/ProductDetailsScreen";
  AllProductsItem? product;
  FavouriteData? favourite;
  bool isfavourite;

  ProductDetailsScreen({
    super.key,
    this.product,
    this.favourite,
    this.isfavourite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product detail"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            isfavourite != true
                ?
// for not favorurite
                product!.productImage.isNotEmpty
                    ? CarouselSlider(
                        options: CarouselOptions(
                          height: 300,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                        ),
                        items: product!.productImage.map((imageUrl) {
                          return Hero(
                            tag: product!.id,
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              placeholder: (context, url) => Shimmer.fromColors(
                                  baseColor: Color.fromARGB(255, 223, 223, 223),
                                  highlightColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  child: Container(
                                    color:
                                        const Color.fromARGB(255, 58, 58, 58),
                                    height: mq.height * 0.12,
                                    width: double.infinity,
                                  )),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.fitWidth,
                              width: double.infinity,
                            ),
                          );
                        }).toList(),
                      )
                    : Hero(
                        tag: product!.id,
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://t.infibeam.com/img/no_image.jpg.999x350x350.jpg",
                          placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Color.fromARGB(255, 223, 223, 223),
                              highlightColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              child: Container(
                                color: const Color.fromARGB(255, 58, 58, 58),
                                height: mq.height * 0.12,
                                width: double.infinity,
                              )),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                        ),
                      )
                :
                // here non fav closed

                favourite!.productDetail[0].productImage.isNotEmpty
                    ? CarouselSlider(
                        options: CarouselOptions(
                          height: 300,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                        ),
                        items: favourite!.productDetail[0].productImage
                            .map((imageUrl) {
                          return Hero(
                            tag: favourite!.productDetail[0].id,
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              placeholder: (context, url) => Shimmer.fromColors(
                                  baseColor: Color.fromARGB(255, 223, 223, 223),
                                  highlightColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  child: Container(
                                    color:
                                        const Color.fromARGB(255, 58, 58, 58),
                                    height: mq.height * 0.12,
                                    width: double.infinity,
                                  )),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.fitWidth,
                              width: double.infinity,
                            ),
                          );
                        }).toList(),
                      )
                    : Hero(
                        tag: favourite!.productDetail[0].id,
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://t.infibeam.com/img/no_image.jpg.999x350x350.jpg",
                          placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Color.fromARGB(255, 223, 223, 223),
                              highlightColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              child: Container(
                                color: const Color.fromARGB(255, 58, 58, 58),
                                height: mq.height * 0.12,
                                width: double.infinity,
                              )),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                        ),
                      ),
            // favourite image closed
            SizedBox(height: 20),
            // Product Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                isfavourite
                    ? favourite!.productDetail[0].productName
                    : product!.productName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // Product Rating
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Row(
            //     children: [
            //       Icon(Icons.star, color: Colors.orange),
            //       Text(
            //         "${product.rating} (${product.reviews} reviews)",
            //         style: TextStyle(fontSize: 16),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 10),
            // Product Price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "\$${isfavourite ? favourite!.productDetail[0].price : product!.price}",
                style: TextStyle(fontSize: 24, color: Colors.green),
              ),
            ),
            SizedBox(height: 20),
            // Product Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                isfavourite
                    ? favourite!.productDetail[0].description
                    : product!.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            // Add to Cart Button
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Add to cart functionality
            //     },
            //     child: Text("Add to Cart"),
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.blue,
            //       foregroundColor: Colors.white,
            //       padding: EdgeInsets.symmetric(vertical: 12),
            //       textStyle: TextStyle(fontSize: 18),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
