import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';

class SearchProduct extends SearchDelegate {
  List _filter = [];

  @override
  String? get searchFieldLabel => 'Search a product';
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  Widget _emptyContainer() {
    return const Center(
        child: Icon(
      Icons.search_off_outlined,
      color: Colors.deepPurple,
      size: 200,
    ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    if (query.isEmpty) {
      return _emptyContainer();
    }
    final productsService = Provider.of<ProductsService>(context);
    final products = productsService.products;

    _filter = products.where((product) {
      return product.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (_filter.isEmpty) {
      return Center(child: Text('There is no products with titled "$query"'));
    }

    return ListView.builder(
        itemCount: _filter.length,
        itemBuilder: (_, index) {
          return ListTile(
            title: Text(_filter[index].title),
            onTap: () {
              productsService.selectedProduct = products[index].copy();
              Navigator.pushNamed(context, 'product');
            },
          );
        });
  }
}
