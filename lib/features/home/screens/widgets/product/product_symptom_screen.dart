import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:shimmer/shimmer.dart';

import 'package:flutter/services.dart';
import 'package:skin_care/features/home/model/favourite_list_model.dart';
import 'package:skin_care/features/home/screens/product_detail_screen.dart';

import '../../../../../dependency_injection.dart';
import '../../../../../main.dart';
import '../../../../../shared/widgets/entry_out_transition_widget.dart';
import '../../../controllers/product/product_bloc.dart';
import '../../../model/all_products.dart';
import 'product_item_shimmer.dart';

class ProductSymptomItemWidget extends StatefulWidget {
  static String id = "/ProductSymptomScreen";
  ProductSymptomItemWidget({
    super.key,
    this.enableEntryAnimation = true,
  });
  final bool enableEntryAnimation;

  @override
  State<ProductSymptomItemWidget> createState() =>
      _ProductSymptomItemWidgetState();
}

class _ProductSymptomItemWidgetState extends State<ProductSymptomItemWidget>
    with TickerProviderStateMixin {
  // List<RelatedProductCategory> RelatedProductCategoryList = [];
  // List<Product> productList = [];

  late final AnimationController entryAnimationController;
  List<Animation<double>> entryAnimations =
      List.filled(8, const AlwaysStoppedAnimation(1));

  @override
  void initState() {
    entryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
      value: 0,
    );
    if (widget.enableEntryAnimation) {
      entryAnimations = List.generate(
        8,
        (index) => CurvedAnimation(
          parent: entryAnimationController,
          curve: Interval(0, .2 * (index + 1), curve: Curves.fastOutSlowIn),
        ),
      );
      Future.delayed(
        const Duration(milliseconds: 400),
        () => entryAnimationController.forward(),
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    entryAnimationController.dispose();
    super.dispose();
  }

  List<AllProductsItem> productList = [];

  List<FavouriteData> favouritedata = [];

  int selectedIndex = 0;

  String title = "";

  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);
    productBloc.add(ProductFetchFav());
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is HomeToSymptomsLoadedState) {
          // log(state.selectedIndex.toString());
          // log(state.productist.map((e) => e.toJson()).toList().toString());

          productList = state.products;
          title = state.title;
          // .where((element) {
          //   return state.relatedProductCategoryList[state.selectedIndex].id ==
          //           element.categoryId &&
          //       state.skintype[state.skintypeindex].id == element.skinTypeId;
          // }).toList();
        }
        if (state is FavouriteListState) {
          favouritedata = state.favouritelist;

          // log("done transferring  ${favouritedata.map((e) => " ${e.productId} ")}");
        }

        return Scaffold(
          appBar: AppBar(
            title: Text("${title} Products"),
          ),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            child: EntryOutTransition(
              entryAnimation: entryAnimations[4],
              // outAnimation: outAnimationController,
              entryBeginOffset: const Offset(0, .5),
              outBeginOffset: const Offset(0, .5),
              child: AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: 300,
                ),
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    Widget child = homeItem();
                    if (state.status == ProductStatus.loading) {
                      return const ProductItemShimmer();
                    }
                    return child;
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget homeItem() => GridView.builder(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          mainAxisExtent: mq.width * 0.50,
        ),
        itemCount: productList.length,
        itemBuilder: (BuildContext context, int index) {
          // bool isSelected = index == selectedIndex;
          final product = productList[index];
          // bool isfavourite=
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return ProductDetailsScreen(
                    product: product,
                  );
                },
              ));
            },
            child: Stack(
              children: [
                Container(
                  height: 390,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 0.2,
                        color: Colors.grey.shade200,
                        blurRadius: 0.6,
                        offset: Offset(2, 3),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Hero(
                          tag: product.id,
                          child: CachedNetworkImage(
                            height: mq.height * 0.14,
                            fit: BoxFit.fitWidth,
                            imageUrl: product.productImage.isNotEmpty
                                ? product.productImage[0]
                                : "https://t.infibeam.com/img/no_image.jpg.999x350x350.jpg",
                            placeholder: (context, url) {
                              return Shimmer.fromColors(
                                  baseColor: Color.fromARGB(255, 223, 223, 223),
                                  highlightColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  child: Container(
                                    color:
                                        const Color.fromARGB(255, 58, 58, 58),
                                    height: mq.height * 0.12,
                                    width: double.infinity,
                                  ));
                            },
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        // Image.asset(
                        //   product.,
                        //   fit: BoxFit.contain,
                        // ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.productName ?? "foo",
                        maxLines: 1,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        maxLines: 1,
                        product.description ?? "foo",
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          // fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -7,
                  right: -7,
                  child: IconButton(
                    icon: Icon(
                      favouritedata
                              .any((element) => element.productId == product.id)

                          // favouritedata.where((element) {
                          //           return element.productId == product.id;
                          //         }) ==
                          //         true
                          // favouritedata.contains(product.id)
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      // print(product.id);
                      context.read<ProductBloc>().add(
                            Favourite(
                                userid: storage.read('userid'),
                                productid: product.id),
                          );
                      // context.read<ProductBloc>().add(Getfavouritelist());
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
}
