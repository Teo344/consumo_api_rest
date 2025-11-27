import 'dart:convert';
import 'package:consumo_api_rest/src/data/datasource/base_datasource.dart';
import 'package:consumo_api_rest/src/data/models/product_model.dart';
import 'package:http/http.dart' as http;



class ProductApiDatasource implements BaseDatasource{
  //url
  final String baseUrl = 'http://172.20.10.2:3000/api/productos';

  @override
  Future<List<ProductModel>> fetchProductos() async {
    final url = Uri.parse(baseUrl);
    final resp = await http.get(url);

    if(resp.statusCode !=200){
      throw Exception("Error al obtener productos");
    }
    final List data = json.decode(resp.body);
    return data.map((item)=>ProductModel.fromJson(item)).toList();
  }
  
  @override
  Future<ProductModel> createProductos(Map<String, dynamic> data) async{
    final resp = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data)
    );

    if(resp.statusCode !=201){
      throw Exception("Error al crear producto");
    }
    return ProductModel.fromJson(json.decode(resp.body));
  }
  
    @override
  Future<ProductModel> updateProductos(String id, Map<String, dynamic> data) async {
    
    
    final resp = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data)
    );

    if(resp.statusCode !=200){
      throw Exception("Error al actualiar productos");
    }
    return ProductModel.fromJson(json.decode(resp.body));
  }


  @override
  Future<bool> deleteProductos(String id) async {
    final resp = await http.delete(Uri.parse("$baseUrl/$id"));
    return resp.statusCode ==200;
  }
  
  
  

}