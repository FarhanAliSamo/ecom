import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/product_model.dart';
import 'package:get/get.dart';

class ProductService {
  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection('products');

  DocumentSnapshot? _lastDocument;

  // Fetch paginated products
  Future<List<ProductModel>> fetchProducts({required int take}) async {
    try {
      Query query =
          _productRef.orderBy('createdAt', descending: true).limit(take);

      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      }

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;
      }

      return snapshot.docs.map((doc) {
        return ProductModel.fromJson(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      e.printError(info: 'Error fetching products with pagination: $e');
      rethrow;
    }
  }

  Future<ProductModel?> getProductById(String productId) async {
    try {
      final doc = await _productRef.doc(productId).get();
      if (doc.exists) {
        return ProductModel.fromJson(
            doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      e.printError(info: 'Error fetching product by id: $e');
      return null;
    }
  }

  void resetPagination() {
    _lastDocument = null;
  }
}
