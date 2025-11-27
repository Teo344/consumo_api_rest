import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/presentation/routes/app_routes.dart';
import 'src/presentation/viewmodel/product_viewmodel.dart';
import 'src/domain/usecases/get_productos_usecase.dart';
import 'src/domain/usecases/create_producto_usecase.dart';
import 'src/domain/usecases/update_product_usecase.dart';
import 'src/domain/usecases/delete_producto_usecase.dart';
import 'src/data/repositories/product_repository.dart';
import 'src/data/datasource/product_api_datasource.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Datasource
  final dataSource = ProductApiDatasource();

  // Repository
  final repository = ProductRepository(dataSource);

  // Usecases
  final getProductosUsecase = GetProductosUsecase(repository);
  final createProductoUsecase = CreateProductoUsecase(repository);
  final updateProductUsecase = UpdateProductUsecase(repository);
  final deleteProductoUsecase = DeleteProductoUsecase(repository);

  runApp(AppProviders(
    getProductosUsecase: getProductosUsecase,
    createProductoUsecase: createProductoUsecase,
    updateProductUsecase: updateProductUsecase,
    deleteProductoUsecase: deleteProductoUsecase,
  ));
}

class AppProviders extends StatelessWidget {
  final GetProductosUsecase getProductosUsecase;
  final CreateProductoUsecase createProductoUsecase;
  final UpdateProductUsecase updateProductUsecase;
  final DeleteProductoUsecase deleteProductoUsecase;

  const AppProviders({
    super.key,
    required this.getProductosUsecase,
    required this.createProductoUsecase,
    required this.updateProductUsecase,
    required this.deleteProductoUsecase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductViewmodel(
            createProductoUsecase,
            updateProductUsecase,
            deleteProductoUsecase,
            useCase: getProductosUsecase,
          )..cargarProductos(), // Carga inicial
          lazy: false,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Consumo API Flutter",
      routes: AppRoute.routes,
    );
  }
}
