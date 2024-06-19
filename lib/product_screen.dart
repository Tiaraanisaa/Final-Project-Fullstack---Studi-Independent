import 'package:flutter/material.dart';
import 'api_service.dart';
import 'add_product_screen.dart';
import 'edit_product_screen.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ApiService _apiService = ApiService();
  List<dynamic> _products = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    print('Fetching products...');
    try {
      final products = await _apiService.getProducts();
      setState(() {
        _products = products;
        _isLoading = false;
      });
      print('Products fetched successfully: $products');
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load products';
        _isLoading = false;
      });
      print('Error fetching products: $e');
    }
  }

  Future<void> _deleteProduct(int id) async {
    try {
      final success = await _apiService.deleteProduct(id);
      if (success) {
        setState(() {
          _products.removeWhere((product) => product['id'] == id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product deleted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to delete product. Please try again.')),
        );
      }
    } catch (e) {
      print('Error deleting product: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Error: Failed to delete product. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/gif/bgProduct.gif'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _errorMessage.isNotEmpty
                ? Center(child: Text(_errorMessage))
                : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('No')),
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Quantity')),
                          DataColumn(label: Text('Category ID')),
                          DataColumn(label: Text('Image URL')),
                          DataColumn(label: Text('Created By')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: _products.asMap().entries.map((entry) {
                          int index = entry.key;
                          var product = entry.value;
                          return DataRow(cells: [
                            DataCell(Text((index + 1).toString())),
                            DataCell(Text(product['name'])),
                            DataCell(Text(product['qty'].toString())),
                            DataCell(Text(product['categoryId'].toString())),
                            DataCell(Text(product['imageUrl'])),
                            DataCell(Text(product['createdBy'])),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditProductScreen(
                                                  product: product),
                                        ),
                                      ).then((_) => _fetchProducts());
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () =>
                                        _deleteProduct(product['id']),
                                  ),
                                ],
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductScreen(),
            ),
          ).then((_) => _fetchProducts());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
