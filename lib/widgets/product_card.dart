import 'package:flutter/material.dart';

import '../models/models.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        decoration: _productDecoration(),
        height: 400,
        child: Stack(
            //Todos los widgets aparecen alineados en la parte inferior (La imagen tambien pero esta abarca todo el espacio disponible)
            alignment: Alignment.bottomLeft,
            children:  [
              _BackgroundImage(url: product.picture,),
              _ProductDetails(title: product.title,description: product.description,),
              Positioned(top: 0, right: 0, child: _PriceTag(price: product.price,)),
             
             if(!product.available )
              const Positioned(top: 0, left: 0, child: _NotAvailable())
             
            ]),
      ),
    );
  }

  BoxDecoration _productDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 8), blurRadius: 10)
          ]);
}

class _NotAvailable extends StatelessWidget {
  const _NotAvailable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container  (
      // ignore: sort_child_properties_last
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            
            'Not available',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      width: 100,
      height: 70,
      decoration: const BoxDecoration(
          color: Colors.deepOrangeAccent,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
    );
  }
}

class _PriceTag extends StatelessWidget {
  final double price;
  const _PriceTag({
    Key? key, required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      //Para poder usar simbolo $ dentro de un text usamos la  '\'
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              ' \$${price}',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
      ),
      width: 100,
      height: 70,
      decoration: const BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), bottomLeft: Radius.circular(25))),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final String title;
  final String ?description;
  const _ProductDetails({
    Key? key, required this.title, this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _detailsDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (description!=null )
            Text(
              description!,
              style:const TextStyle(fontSize: 15, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
            
            ,
          ],
        ),
      ),
    );
  }

  BoxDecoration _detailsDecoration() => const BoxDecoration(
      color: Colors.deepPurple,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25), topRight: Radius.circular(25)));
}

class _BackgroundImage extends StatelessWidget {
  final String ? url;
  const _BackgroundImage({
    Key? key, this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      // ignore: sized_box_for_whitespace
      child: Container(
        width: double.infinity,
        height: 400,
        //FadeinImage nos permite tener un placeholder que es la imagen mientras se carga y tambien la imagen oficial que nosotros queremos mostrar

        child: url ==null ?
        const FadeInImage(
        placeholder: AssetImage('assets/loading-11.gif'), 
        image: AssetImage('assets/no-image.png'),
        fit: BoxFit.cover,
        )
        :
        FadeInImage(
          placeholder:const AssetImage('assets/loading-11.gif'),
          image:NetworkImage(url!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
