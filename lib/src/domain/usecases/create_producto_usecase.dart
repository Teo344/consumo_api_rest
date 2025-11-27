import '../entities/product_entity.dart';
import '../../data/repositories/base_repository.dart';

class CreateProductoUsecase {
  
    final BaseRepository repository;

  CreateProductoUsecase(this.repository);



    Future<ProductEntity> call(ProductEntity p) async {//llama al repositorio para crear el producto
        return await repository.createProductos(p);
}


}
