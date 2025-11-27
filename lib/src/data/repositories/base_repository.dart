import '../../domain/entities/product_entity.dart';

abstract class BaseRepository {
  Future <List<ProductEntity>> getProductos();
  Future <ProductEntity> createProductos(ProductEntity p);
  Future <ProductEntity> updateProductos(String id, ProductEntity p);
  Future <bool> deleteProductos(String id);
}