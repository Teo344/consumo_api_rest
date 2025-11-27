import 'package:consumo_api_rest/src/data/datasource/base_datasource.dart';

class ProductEntity {
  final String id;
  final String nombre;
  final double price;
  final int stock;
  final String categoria;

  ProductEntity({required this.id, required this.nombre, required this.price, required this.stock, required this.categoria});
  
}