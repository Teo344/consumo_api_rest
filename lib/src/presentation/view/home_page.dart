import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/product_entity.dart';
import '../viewmodel/product_viewmodel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductViewmodel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Productos")),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: vm.productos.length,
              itemBuilder: (_, i) {
                final p = vm.productos[i];
                return ListTile(
                  title: Text(p.nombre),
                  subtitle: Text("Precio: \$${p.price} - Stock: ${p.stock}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _mostrarModalEditar(context, vm, p),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _confirmarEliminar(context, vm, p),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarModalAgregar(context, vm),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _mostrarModalAgregar(BuildContext context, ProductViewmodel vm) {
    final _nombreController = TextEditingController();
    final _priceController = TextEditingController();
    final _stockController = TextEditingController();
    final _categoriaController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Agregar Producto"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(controller: _nombreController, decoration: const InputDecoration(labelText: "Nombre")),
                TextField(controller: _priceController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Precio")),
                TextField(controller: _stockController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Stock")),
                TextField(controller: _categoriaController, decoration: const InputDecoration(labelText: "Categoría")),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text("Cancelar")),
            ElevatedButton(
              onPressed: () async {
                final nuevoProducto = ProductEntity(
                  id: '',
                  nombre: _nombreController.text.trim(),
                  price: double.tryParse(_priceController.text) ?? 0,
                  stock: int.tryParse(_stockController.text) ?? 0,
                  categoria: _categoriaController.text.trim(),
                );
                await vm.agregarProductos(nuevoProducto);
                Navigator.of(ctx).pop();
              },
              child: const Text("Agregar"),
            ),
          ],
        );
      },
    );
  }

  void _mostrarModalEditar(BuildContext context, ProductViewmodel vm, ProductEntity p) {
    final _nombreController = TextEditingController(text: p.nombre);
    final _priceController = TextEditingController(text: p.price.toString());
    final _stockController = TextEditingController(text: p.stock.toString());
    final _categoriaController = TextEditingController(text: p.categoria);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Editar Producto"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(controller: _nombreController, decoration: const InputDecoration(labelText: "Nombre")),
                TextField(controller: _priceController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Precio")),
                TextField(controller: _stockController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Stock")),
                TextField(controller: _categoriaController, decoration: const InputDecoration(labelText: "Categoría")),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text("Cancelar")),
            ElevatedButton(
              onPressed: () async {
                final actualizado = ProductEntity(
                  id: p.id,
                  nombre: _nombreController.text.trim(),
                  price: double.tryParse(_priceController.text) ?? 0,
                  stock: int.tryParse(_stockController.text) ?? 0,
                  categoria: _categoriaController.text.trim(),
                );
                await vm.editarProductos(p.id, actualizado);
                Navigator.of(ctx).pop();
              },
              child: const Text("Guardar"),
            ),
          ],
        );
      },
    );
  }

  void _confirmarEliminar(BuildContext context, ProductViewmodel vm, ProductEntity p) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirmar eliminación"),
        content: Text("¿Deseas eliminar '${p.nombre}'?"),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () async {
              await vm.eliminarProductos(p.id);
              Navigator.of(ctx).pop();
            },
            child: const Text("Eliminar"),
          ),
        ],
      ),
    );
  }
}
