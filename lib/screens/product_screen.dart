import 'package:ecommerce_app/providers/providers.dart';
import 'package:ecommerce_app/services/services.dart';
import 'package:ecommerce_app/ui/input_decorations.dart';
import 'package:ecommerce_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);
    final productS = productService.selectedProduct;
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productS!),
      child: _ProductScreenBody(product: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductsService product;

  @override
  Widget build(BuildContext context) {
    final productFormProvider=Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
          //Al hacer scroll se oculta el teclado
          //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

          child: Column(
        children: [
          Stack(
            children: [
              ProductImage(url: product.selectedProduct?.picture),
              Positioned(
                // ignore: sort_child_properties_last
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 40,
                    )),
                top: 60,
                left: 20,
              ),
              Positioned(
                // ignore: sort_child_properties_last
                child: IconButton(
                    onPressed: () async{
                      //uso de la camara con el paquete image_picker
                      final picker= ImagePicker();
                      final XFile ? pickedFile=await picker.pickImage(source: ImageSource.camera);
                      if (pickedFile==null){
                        return;
                        
                      }else{
                    product.updateSelectedProductImg(pickedFile.path);
                      }

                    },
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                      size: 40,
                    )),
                top: 60,
                right: 20,
              )
            ],
          ),
          const _EditForm(),
          const SizedBox(
            height: 100,
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        // ignore: sort_child_properties_last
        child: product.isSaving? 
      const CircularProgressIndicator(color: Colors.white)
        :
     const Icon(Icons.save_alt_outlined),
        onPressed: product.isSaving 
        ? null 
        :      
        () async{
          if(!productFormProvider.isValidForm())return;
          final String? imgUrl=await product.uploadImg();
          if(imgUrl!=null){
            productFormProvider.product.picture=imgUrl;
        
          }
         await product.saveOrCreateProduct(productFormProvider.product);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _EditForm extends StatelessWidget {
  const _EditForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: _formDecoration(),
        width: double.infinity,
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: productForm.formkey,
            child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              style: const TextStyle(color: Colors.black),
              initialValue: product.title,
              onChanged: (value) => product.title = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'The title must be provided';
                }
              },
              decoration: InputDecorations.loginInputDecoration(
                hintText: 'Product title',
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              style: const TextStyle(color: Colors.black),
              initialValue: product.description,
              onChanged: (value) =>product.description=value ,
              decoration: InputDecorations.loginInputDecoration(
                hintText: 'Product description',
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              style: const TextStyle(color: Colors.black),
              //Para poner diferentes reglas para darle formato al texto
              inputFormatters: [
                //import flutter/services.dart
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ],
              initialValue: '\$${product.price}',
              onChanged: (value) {
                //Si es igual a null significa que no se pudo parsear
                if (double.tryParse(value) == null) {
                  product.price = 0;
                } else {
                  product.price = double.parse(value);
                }
              },

              //Teclado numerico
              keyboardType: TextInputType.number,
              decoration: InputDecorations.loginInputDecoration(
                hintText: '\$150',
                labelText: 'Price',
              ),
            ),
            const SizedBox(height: 30),
            SwitchListTile.adaptive(
                value: product.available,
                title: const Text('Disponible'),
                activeColor: Colors.deepPurple,
                onChanged: productForm.updateAvailability,
                ),
            const SizedBox(height: 30)
          ],
        )),
      ),
    );
  }

  BoxDecoration _formDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]);



}









