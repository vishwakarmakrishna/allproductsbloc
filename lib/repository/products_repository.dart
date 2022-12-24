import 'package:access/models/product_respone.dart';
import 'package:access/networking/api_base_helper.dart';

class ProductsRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Product>?> fetchproductslist() async {
    final response = await _helper.get("products");
    return productFromJson(response.toString());
  }
}
