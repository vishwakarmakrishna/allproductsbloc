import 'dart:async';
import 'package:access/models/product_respone.dart';
import 'package:access/networking/api_response.dart';
import 'package:access/repository/products_repository.dart';
import 'package:flutter/material.dart';

class ProductsBloc {
  late ProductsRepository _productsRepository;

  late StreamController<ApiResponse<List<Product>>> _productsListController;

  StreamSink<ApiResponse<List<Product>>> get productsListSink =>
      _productsListController.sink;

  Stream<ApiResponse<List<Product>>> get productsListStream =>
      _productsListController.stream;

  ProductsBloc() {
    _productsListController = StreamController<ApiResponse<List<Product>>>();
    _productsRepository = ProductsRepository();
    fetchproductslist();
  }

  fetchproductslist() async {
    productsListSink.add(ApiResponse.loading('Fetching Products'));
    try {
      List<Product>? products = await _productsRepository.fetchproductslist();
      productsListSink.add(ApiResponse.completed(products));
    } catch (e) {
      productsListSink.add(ApiResponse.error(e.toString()));
      debugPrint('$e');
    }
  }

  dispose() {
    _productsListController.close();
  }
}
