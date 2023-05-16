import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../models/payment_type_model.dart';
import '../../repositories/payment_type/payment_type_repository.dart';

part 'payment_type_controller.g.dart';

class PaymentTypeController = PaymentTypeControllerBase
    with _$PaymentTypeController;

enum PaymentTypeStateStatus {
  initial,
  loading,
  loaded,
  error,
  addOrUpdatePayment,
  saved,
}

abstract class PaymentTypeControllerBase with Store {
  final PaymentTypeRepository _paymentTypeRepository;

  PaymentTypeControllerBase(this._paymentTypeRepository);

  @readonly
  var _status = PaymentTypeStateStatus.initial;

  @readonly
  var _paymentTypes = <PaymentTypeModel>[];

  @readonly
  PaymentTypeModel? _paymentTypeSelected;

  @readonly
  String? _errorMessage;

  @readonly
  bool? _filterEnabled;

  @action
  void changeFilter(bool? enabled) => _filterEnabled = enabled;

  @action
  Future<void> loadPayments() async {
    try {
      _status = PaymentTypeStateStatus.loading;

      _paymentTypes = await _paymentTypeRepository.findAll(_filterEnabled);

      _status = PaymentTypeStateStatus.loaded;
    } on Exception catch (e, s) {
      log('Erro ao carregar as formas de pagamento', error: e, stackTrace: s);

      _status = PaymentTypeStateStatus.error;

      _errorMessage = 'Erro ao carregar as formas de pagamento';
    }
  }

  @action
  Future<void> addPayment() async {
    _status = PaymentTypeStateStatus.loading;
    await Future.delayed(Duration.zero);

    _paymentTypeSelected = null;

    _status = PaymentTypeStateStatus.addOrUpdatePayment;
  }

  @action
  Future<void> editPayment(PaymentTypeModel payment) async {
    _status = PaymentTypeStateStatus.loading;

    await Future.delayed(Duration.zero);

    _paymentTypeSelected = payment;

    _status = PaymentTypeStateStatus.addOrUpdatePayment;
  }

  @action
  Future<void> savePayment({
    required String name,
    required String acronym,
    required bool enabled,
    int? id,
  }) async {
    _status = PaymentTypeStateStatus.loading;

    final paymentTypeModel = PaymentTypeModel(
      name: name,
      acronym: acronym,
      enabled: enabled,
      id: id,
    );

    await _paymentTypeRepository.save(paymentTypeModel);

    _status = PaymentTypeStateStatus.saved;
  }
}
