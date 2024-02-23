import 'package:flutter/material.dart';
import 'package:practical/model/product_model.dart';
import 'package:practical/utils/custom_text_style.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
              width: MediaQuery.of(context).size.width,
              child: Image.network(product.image!)),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title!,
                  style: CustomTextStyles().productTitleTextStyle,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: Text('\$${product.price!}')),
                    Text(product.rating!.rate.toString()),
                    const SizedBox(width: 5),
                    const Icon(Icons.star_rate,size: 18),
                  ],
                ),
                const SizedBox(height: 20),
                Text(product.description!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
