// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductDetailController on ProductDetailControllerBase, Store {
  late final _$_statusAtom =
      Atom(name: 'ProductDetailControllerBase._status', context: context);

  ProductDetailStateStatus get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  ProductDetailStateStatus get _status => status;

  @override
  set _status(ProductDetailStateStatus value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  late final _$_erroMessageAtom =
      Atom(name: 'ProductDetailControllerBase._erroMessage', context: context);

  String? get erroMessage {
    _$_erroMessageAtom.reportRead();
    return super._erroMessage;
  }

  @override
  String? get _erroMessage => erroMessage;

  @override
  set _erroMessage(String? value) {
    _$_erroMessageAtom.reportWrite(value, super._erroMessage, () {
      super._erroMessage = value;
    });
  }

  late final _$_imagePathAtom =
      Atom(name: 'ProductDetailControllerBase._imagePath', context: context);

  String? get imagePath {
    _$_imagePathAtom.reportRead();
    return super._imagePath;
  }

  @override
  String? get _imagePath => imagePath;

  @override
  set _imagePath(String? value) {
    _$_imagePathAtom.reportWrite(value, super._imagePath, () {
      super._imagePath = value;
    });
  }

  late final _$uploadImageProductAsyncAction = AsyncAction(
      'ProductDetailControllerBase.uploadImageProduct',
      context: context);

  @override
  Future<void> uploadImageProduct(Uint8List file, String filename) {
    return _$uploadImageProductAsyncAction
        .run(() => super.uploadImageProduct(file, filename));
  }

  late final _$saveAsyncAction =
      AsyncAction('ProductDetailControllerBase.save', context: context);

  @override
  Future<void> save(String name, double price, String description) {
    return _$saveAsyncAction.run(() => super.save(name, price, description));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
