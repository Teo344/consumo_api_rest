import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity{
  ProductModel({required super.id, required super.nombre, required super.price, required super.stock, required super.categoria});

//metodo Factory
factory ProductModel.fromJson(Map<String, dynamic> json) {
  return ProductModel(
    id: json['_id']?.toString() ?? "",
    nombre: json['nombre'] ?? "",
    price: (json['price'] ?? 0).toDouble(),
    stock: json['stock'] ?? 0,
    categoria: json['categoria'] ?? "",
  );
}


 //paso de JSON a objeto

 
}


