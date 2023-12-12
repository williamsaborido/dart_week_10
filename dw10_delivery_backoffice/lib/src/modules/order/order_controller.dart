// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../models/orders/order_model.dart';
import '../../models/orders/order_status.dart';
import '../../repositories/order/order_repository.dart';

part 'order_controller.g.dart';

enum OrderStateStatus {
  initial,
  loading,
  loaded,
  error,
  showDetailModal,
}

class OrderController = OrderControllerBase with _$OrderController;

abstract class OrderControllerBase with Store {
  final OrderRepository _orderRepository;

  @readonly
  var _status = OrderStateStatus.initial;

  @readonly
  OrderStatus? _statusFilter;

  @readonly
  String? _errorMessage;

  @readonly
  var _orders = <OrderModel>[];

  late final DateTime _today;

  OrderControllerBase(this._orderRepository) {
    final todayNow = DateTime.now();

    _today = DateTime(todayNow.year, todayNow.month, todayNow.day);
  }

  @action
  Future<void> findOrders() async {
    try {
      _status = OrderStateStatus.loading;

      _orders = await _orderRepository.findAllOrders(_today, _statusFilter);

      _status = OrderStateStatus.loaded;
    } on Exception catch (e, s) {
      log('Erro ao buscar pedidos do dia', error: e, stackTrace: s);

      _status = OrderStateStatus.error;

      _errorMessage = 'Erro ao buscar pedidos';
    }
  }

  @action
  Future<void> showDetailModal(OrderModel model) async {
    _status = OrderStateStatus.loading;

    await Future.delayed(Duration.zero);

    _status = OrderStateStatus.showDetailModal;
  }
}
