import 'package:ecommerce_app/screens/screens.dart';
import 'package:ecommerce_app/search/search_products.dart';
import 'package:ecommerce_app/services/services.dart';
import 'package:ecommerce_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    final products = productsService.products;
    //No necesito que se redibuje que este escuchando=>Listen en false.
    final authService=Provider.of<AuthService>(context,listen: false);
    if (productsService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
            showSearch(context: context,
             delegate: SearchProduct());

            },
          ),
          
        ],
        leading: IconButton(
            icon: const Icon(Icons.login_outlined),
            onPressed: () {
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),

        //Para centrar el AppBar
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () {
                //creo una copia del producto para romper la referencia y poder hacer cualquier modificacion a este selected product y no va a afectar al producto en particular
                productsService.selectedProduct = products[index].copy();
                Navigator.pushNamed(context, 'product');
              },
              child: ProductCard(
                product: products[index],
              ))),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          productsService.selectedProduct =
              Product(available: true, price: 0, title: '');
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}
