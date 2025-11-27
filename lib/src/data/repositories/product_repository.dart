import '../../domain/entities/product_entity.dart';
import '../../data/datasource/base_datasource.dart';
import '../models/product_model.dart';

import 'base_repository.dart';

class ProductRepository implements BaseRepository {
  final BaseDatasource ds;

  ProductRepository(this.ds);

  @override
  Future<List<ProductEntity>> getProductos() {
    return ds.fetchProductos(); //llama al datasource
  }

  @override
  Future<ProductEntity> createProductos(ProductEntity p) {
    final data = {
      "nombre": p.nombre,
      "precio": p.price,
      "stock": p.stock,
      "categoria": p.categoria,
    };

    print(
      "🚀 Enviando datos al backend: $data",
    ); // <-- Aquí ves qué estás enviando

    return ds.createProductos(data);
  }

  @override
  Future<bool> deleteProductos(String id) {
    return ds.deleteProductos(id);
  }

  @override
  Future<ProductEntity> updateProductos(String id, ProductEntity p) {
    return ds.updateProductos(id, {
      "nombre": p.nombre,
      "precio": p.price,
      "stock": p.stock,
      "categoria": p.categoria,
    });
  }
}
