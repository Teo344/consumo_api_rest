import 'package:consumo_api_rest/src/domain/usecases/create_producto_usecase.dart';
import 'package:consumo_api_rest/src/domain/usecases/delete_producto_usecase.dart';
import 'package:consumo_api_rest/src/domain/usecases/update_product_usecase.dart';

import '../../domain/entities/product_entity.dart';

import '../../domain/usecases/get_productos_usecase.dart';
import 'base_viewmodel.dart';

class ProductViewmodel extends BaseViewmodel {
  final GetProductosUsecase useCase;
  final CreateProductoUsecase createProductoUsecase;
  final UpdateProductUsecase updateProductUsecase;
  final DeleteProductoUsecase deleteProductoUsecase;

  List<ProductEntity> productos = [];

  //ProductViewmodel(this.createProductoUsecase, this.updateProductUsecase, this.deleteProductoUsecase,  this.useCase, {required GetProductosUsecase useCase});

  ProductViewmodel(this.createProductoUsecase, this.updateProductUsecase, this.deleteProductoUsecase,{required this.useCase});

  Future<void> cargarProductos() async {
    setLoading(true);
    productos = await useCase();
    setLoading(false);
    notifyListeners();
  }


    Future<void> agregarProductos(ProductEntity p) async {
      await createProductoUsecase.call(p);
      await cargarProductos(); // Recargamos la lista después de agregar
  } 

  Future<void> editarProductos(String id, ProductEntity p) async{
    await updateProductUsecase(id, p);
    await cargarProductos();
  }

  Future <void> eliminarProductos(String id) async{
    await deleteProductoUsecase(id);
    await cargarProductos();
  }

}
