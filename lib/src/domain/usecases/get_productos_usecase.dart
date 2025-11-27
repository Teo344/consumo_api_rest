import '../entities/product_entity.dart';
import '../../data/repositories/base_repository.dart';

class GetProductosUsecase {
  
    final BaseRepository repository;

    GetProductosUsecase(this.repository);

Future<List<ProductEntity>> call() async {
  print("USECASE -> Llamando repository.getProductos()");
  final data = await repository.getProductos();
  print("USECASE -> Recibidos: ${data.length}");
  return data;
}

}
