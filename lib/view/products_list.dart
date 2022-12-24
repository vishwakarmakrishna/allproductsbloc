import 'package:access/models/product_respone.dart';
import 'package:flutter/material.dart';

import 'product_card.dart';

class ProductsList extends StatefulWidget {
  final List<Product>? productsList;

  const ProductsList({Key? key, this.productsList}) : super(key: key);

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  late TextEditingController searchController;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  List<Product> searchedproductsList() {
    List<Product> searchedproductsList = [];
    if (widget.productsList != null) {
      for (var i = 0; i < widget.productsList!.length; i++) {
        if (widget.productsList![i].title
            .toLowerCase()
            .contains(searchController.text.toLowerCase())) {
          searchedproductsList.add(widget.productsList![i]);
        }
      }
    }

    return searchedproductsList;
  }

  List<Product> get productsList => searchController.text.isEmpty
      ? widget.productsList ?? <Product>[]
      : searchedproductsList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            controller: searchController,
            onChanged: (value) {
              setState(() {});
            },
            style: const TextStyle(
              color: Colors.red,
            ),
            decoration: const InputDecoration(
              fillColor: Colors.transparent,
              hintText: 'Search',
              hintStyle: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.red,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
            ),
          ),
        ),
      ),
      body: GridView.builder(
        itemCount: productsList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5 / 1.8,
        ),
        itemBuilder: (context, index) {
          final product = productsList.elementAt(index);
          return ProductCard(product: product);
        },
      ),
    );
  }
}
