// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../../models/product_model.dart';
import '../../../repositories/products/product_repository.dart';

part 'products_controller.g.dart';

enum ProductStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class ProductsController = ProductsControllerBase with _$ProductsController;

abstract class ProductsControllerBase with Store {
  final ProductRepository _productRepository;

  ProductsControllerBase(this._productRepository);

  @readonly
  var _status = ProductStateStatus.initial;

  @readonly
  var _products = <ProductModel>[];

  @readonly
  String? _filtername;

  @action
  Future<void> loadProducts() async {
    try {
      _status = ProductStateStatus.loading;

      _products = await _productRepository.findAll(_filtername);

      _status = ProductStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      _status = ProductStateStatus.error;
    }
  }

  @action
  Future<void> filterByName(String name) async {
    _filtername = name;

    await loadProducts();
  }
}
