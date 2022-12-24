// This file is "main.dart"
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'rating_respone.dart';

part 'product_respone.freezed.dart';
part 'product_respone.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required String title,
    required double price,
    required String description,
    required String category,
    required String image,
    required Rating rating,
  }) = _Product;

  factory Product.fromJson(Map<String, Object?> json) =>
      _$ProductFromJson(json);
}

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));
