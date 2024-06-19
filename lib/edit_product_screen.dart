import 'package:flutter/material.dart';
import 'api_service.dart';

class EditProductScreen extends StatefulWidget {
  final dynamic product;

  EditProductScreen({required this.product});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController _nameController;
  late TextEditingController _qtyController;
  late TextEditingController _categoryIdController;
  late TextEditingController _imageUrlController;
  late TextEditingController _updatedByController;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product['name']);
    _qtyController =
        TextEditingController(text: widget.product['qty'].toString());
    _categoryIdController =
        TextEditingController(text: widget.product['categoryId'].toString());
    _imageUrlController =
        TextEditingController(text: widget.product['imageUrl']);
    _updatedByController =
        TextEditingController(text: widget.product['updatedBy']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _qtyController.dispose();
    _categoryIdController.dispose();
    _imageUrlController.dispose();
    _updatedByController.dispose();
    super.dispose();
  }

  Future<void> _updateProduct() async {
    final name = _nameController.text;
    final qty = int.tryParse(_qtyController.text) ?? 0;
    final categoryId = int.tryParse(_categoryIdController.text) ?? 0;
    final imageUrl = _imageUrlController.text;
    final updatedBy = _updatedByController.text;

    try {
      final success = await _apiService.updateProduct(widget.product['id'], {
        'name': name,
        'qty': qty,
        'categoryId': categoryId,
        'imageUrl': imageUrl,
        'updatedBy': updatedBy,
      });

      if (success) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product updated successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to update product. Please try again.')),
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
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                controller: _updatedByController,
                decoration: InputDecoration(labelText: 'Updated By'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProduct,
                child: Text('Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
