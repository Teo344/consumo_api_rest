import '../entities/product_entity.dart';
import '../../data/repositories/base_repository.dart';

class DeleteProductoUsecase {
  
    final BaseRepository repository;

  DeleteProductoUsecase(this.repository);



    Future<bool> call(String id) async {//llama al repositorio para eliminar el producto
        return await repository.deleteProductos(id);
        
    }


}
