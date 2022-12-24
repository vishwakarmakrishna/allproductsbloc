import 'package:access/models/product_respone.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'product_details.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              product: product,
            ),
          ),
        );
      },
      child: Card(
        elevation: 5.0,
        // surfaceTintColor: Colors.white,
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridTile(
            footer: Container(
              height: 45.0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: const BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              alignment: Alignment.center,
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    product.title,
                    colors: [
                      Colors.white,
                      Colors.yellow,
                      Colors.yellow,
                      Colors.white,
                    ],
                    textAlign: TextAlign.center,
                    textStyle: const TextStyle(
                      overflow: TextOverflow.fade,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                totalRepeatCount: 99999,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
                isRepeatingAnimation: true,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Hero(
                tag: '${product.id}',
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                  colorBlendMode: BlendMode.dstATop,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
