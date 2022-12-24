import 'package:access/blocs/products_bloc.dart';
import 'package:access/models/product_respone.dart';
import 'package:access/networking/api_response.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'all_states.dart';
import 'products_list.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late ProductsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ProductsBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText(
              'All Products',
              textStyle: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            ColorizeAnimatedText(
              'All Products',
              colors: [
                Colors.yellowAccent.shade700,
                Colors.orange,
                Colors.orangeAccent,
                Colors.yellowAccent.shade700,
              ],
              textStyle: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          isRepeatingAnimation: true,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchproductslist(),
        child: StreamBuilder<ApiResponse<List<Product>>>(
          stream: _bloc.productsListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data?.status) {
                case null:
                  return Loading(loadingMessage: snapshot.data?.message);
                case Status.loading:
                  return Loading(loadingMessage: snapshot.data?.message);

                case Status.completed:
                  return ProductsList(productsList: snapshot.data?.data);

                case Status.error:
                  return Error(
                    errorMessage: snapshot.data?.message,
                    onRetryPressed: () => _bloc.fetchproductslist(),
                  );
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
