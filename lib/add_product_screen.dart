import 'package:flutter/material.dart';
import 'api_service.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _qtyController = TextEditingController();
  final _categoryIdController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _createdByController = TextEditingController();
  final ApiService _apiService = ApiService();

  Future<void> _addProduct() async {
    final name = _nameController.text;
    final qty = int.tryParse(_qtyController.text) ?? 0; // Handle parsing error
    final categoryId =
        int.tryParse(_categoryIdController.text) ?? 0; // Handle parsing error
    final imageUrl = _imageUrlController.text;
    final createdBy = _createdByController.text;

    try {
      final success = await _apiService.addProduct({
        'name': name,
        'qty': qty,
        'categoryId': categoryId,
        'imageUrl': imageUrl,
        'createdBy': createdBy,
      });

      if (success) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product added successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add product. Please try again.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _qtyController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _categoryIdController,
              decoration: InputDecoration(labelText: 'Category ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: _createdByController,
              decoration: InputDecoration(labelText: 'Created By'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addProduct,
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
