import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-ecommerce-eb38c-default-rtdb.firebaseio.com';
//final porque no quiero destruir el objeto y volverlo a asignar si no solo cambiar sus valores
  final List<Product> products = [];
//No es final porque va a estar cambiando entre true y false
  bool isLoading = true;
  bool isSaving = false;
  File? newImg;
  Product? selectedProduct;
  final storage=FlutterSecureStorage();

  ProductsService() {
    loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'products.json',{'auth':await storage.read(key: 'token')??''});
    final response = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(response.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });
    isLoading = false;
    notifyListeners();
    return products;
  }

  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      //crea prod
      await createProduct(product);
    } else {
      //actualiza
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json',{'auth':await storage.read(key: 'token')??''});
    await http.put(url, body: product.toJson());
    final index = products.indexWhere((e) => e.id == product.id);
    products[index] = product;

    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/products.json');
    final response = await http.put(url, body: product.toJson());
    final decodedData=json.decode(response.body);
    product.id=decodedData['name'];
    products.add(product);
    return product.id!;
  }


  void updateSelectedProductImg(String path){
    selectedProduct?.picture=path;
    newImg=File.fromUri(Uri(path:path));
    notifyListeners();

  }

  Future <String?>uploadImg()async{
    if(newImg==null){
      return null;
    }
    isSaving=true;
    notifyListeners();
    final url=Uri.parse('https://api.cloudinary.com/v1_1/dxrku0ime/image/upload?upload_preset=dzsh6kgc');
    final imgRequestUpload=http.MultipartRequest(
      'POST',
      url,
    );
    final file=await http.MultipartFile.fromPath('file', newImg!.path);
    imgRequestUpload.files.add(file);
    final response=await imgRequestUpload.send();

    final resp=await http.Response.fromStream(response);

    if(resp.statusCode!=200&& resp.statusCode!=201){
      print(resp.body);
      return null;
    }
    //ya lo subi,limpio la propiedad
    newImg=null;
    final data=json.decode(resp.body);
    return data['secure_url'];

  }
}
