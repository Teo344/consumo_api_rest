import '../entities/product_entity.dart';
import '../../data/repositories/base_repository.dart';

class UpdateProductUsecase {
  
    final BaseRepository repository;

  UpdateProductUsecase(this.repository);



    Future<ProductEntity> call(String id, ProductEntity p) async {//llama al repositorio para actualizar el producto
        return await repository.updateProductos(id,p);
}


}
