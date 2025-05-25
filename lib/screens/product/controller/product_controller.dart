import 'package:ecom/models/product_model.dart';
import 'package:ecom/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductService _productService = ProductService();

  var products = <ProductModel>[].obs;
  var isLoading = false.obs;
  var isPageEnd = false.obs;
  final int pageSize = 10;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getProducts();

    scrollController.addListener(scrollListener);
  }

  Future<void> getProducts({bool reset = false}) async {
    if (isPageEnd.value || isLoading.value) return;

    try {
      isLoading.value = true;
      if (reset) {
        _productService.resetPagination();
        products.clear();
        isPageEnd.value = false;
      }

      final fetched = await _productService.fetchProducts(take: pageSize);

      if (fetched.isEmpty) {
        isPageEnd.value = true;
      } else {
        products.addAll(fetched);
        if (fetched.length < pageSize) {
          isPageEnd.value = true;
        }
      }
    } catch (e) {
      e.printError(info: 'Failed to load products');
    } finally {
      isLoading.value = false;
    }
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading.value &&
        !isPageEnd.value) {
      getProducts();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
