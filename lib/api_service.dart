import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:async';

class ApiService {
  final String _baseUrl = Platform.isAndroid
      ? 'http://192.168.107.239:3000/api'
      : 'http://localhost:3000/api';

  final String _productBaseUrl = Platform.isAndroid
      ? 'http://192.168.107.239:3000'
      : 'http://localhost:3000';

  Future<bool> registerUser(
      String username, String password, String imagePath) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$_baseUrl/register'));
    request.fields['username'] = username;
    request.fields['password'] = password;
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));

    var response = await request.send().timeout(Duration(seconds: 30));

    if (response.statusCode == 201) {
      print('User registered successfully');
      return true;
    } else {
      print('Failed to register user');
      return false;
    }
  }

  Future<bool> loginUser(String username, String password) async {
    var response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print('User logged in successfully');
      return true;
    } else {
      print('Failed to login user. Status code: ${response.statusCode}');
      return false;
    }
  }

  Future<List<dynamic>> getProducts() async {
    final response = await http.get(Uri.parse('$_productBaseUrl/products'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<bool> addProduct(Map<String, dynamic> productData) async {
    final response = await http.post(
      Uri.parse('$_productBaseUrl/products'),
      body: jsonEncode(productData),
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 200;
  }

  Future<bool> updateProduct(
      int productId, Map<String, dynamic> updatedData) async {
    final response = await http.put(
      Uri.parse('$_productBaseUrl/products/$productId'),
      body: jsonEncode(updatedData),
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 200;
  }

  Future<bool> deleteProduct(int productId) async {
    try {
      final response = await http.delete(
        Uri.parse('$_productBaseUrl/products/$productId'),
      );
      if (response.statusCode == 200) {
        print('Product deleted successfully.');
        return true;
      } else {
        print('Failed to delete product. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception while deleting product: $e');
      return false;
    }
  }
}
