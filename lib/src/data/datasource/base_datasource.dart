import '../models/product_model.dart';

abstract class BaseDatasource {
  Future <List <ProductModel>> fetchProductos();
  Future <ProductModel> createProductos(Map<String, dynamic> data);
  Future <ProductModel> updateProductos(String id, Map<String, dynamic> data );
  Future <bool> deleteProductos(String id);

}