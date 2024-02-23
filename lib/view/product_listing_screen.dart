import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical/controller/controller.dart';
import 'package:practical/utils/Dialogs.dart';
import 'package:practical/utils/app_decoration.dart';
import 'package:practical/utils/custom_text_style.dart';
import 'package:practical/view/login_screen.dart';
import 'package:practical/view/product_details_screen.dart';
import 'package:practical/view/registration_screen.dart';

import '../utils/primary_colors.dart';

class ProductListingScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  final bool isFavorite;

  ProductListingScreen({super.key, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isFavorite ? 'Favorite Product Listing' : 'Product Listing'),
        actions: [
          isFavorite
              ? Container()
              : Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProductListingScreen(
                              isFavorite: true,
                            ),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.favorite),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => const RegistrationScreen(
                            isFromEdit: true,
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.person,
                          size: 30,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        Dialogs.showLoadingDialog(context);
                        await FirebaseAuth.instance.signOut();
                        Get.back();
                        Get.offAll(() => const LoginScreen());
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.logout,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
      body: buildProductList(isFavorite),
    );
  }

  buildProductList(bool isFavorite) {
    return Obx(() {
      if (isFavorite ? productController.favoritesList.isEmpty : productController.productsList.isEmpty) {
        if (isFavorite) {
          return const Center(
            child: Text("No FavoritesList Data Found"),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      } else {
        return ListView.builder(
          itemCount: isFavorite ? productController.favoritesList.length : productController.productsList.length,
          itemBuilder: (context, index) {
            final product = isFavorite ? productController.favoritesList[index] : productController.productsList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => ProductDetailScreen(product));
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  width: double.infinity,
                  decoration: AppDecoration.boxShadowDecoration,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 110,
                            width: 110,
                            child: Image.network(product.image!, fit: BoxFit.contain),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10, right: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title!,
                                    style: CustomTextStyles().productTitleTextStyle.copyWith(
                                      fontSize: 16
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text('\$${product.price!}'),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        right: 0,
                        bottom: -10,
                        child: GestureDetector(
                          onTap: () {
                            productController.toggleFavorite(product);
                          },
                          child: Container(
                            decoration: AppDecoration.favIconDecoration,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(product.isFavorite ?? false ? Icons.favorite : Icons.favorite_border,
                                  size: 18, color: product.isFavorite ?? false ? PrimaryColors().redColor : PrimaryColors().blackColor),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    });
  }
}
