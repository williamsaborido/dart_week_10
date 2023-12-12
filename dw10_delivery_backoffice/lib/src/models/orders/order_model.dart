// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'order_product_model.dart';
import 'order_status.dart';

class OrderModel {
  final int id;
  final DateTime data;
  final OrderStatus status;
  final List<OrderProductModel> orderProducts;
  final int userId;
  final String address;
  final String cpf;
  final int paymentTypeTd;

  OrderModel({
    required this.id,
    required this.data,
    required this.status,
    required this.orderProducts,
    required this.userId,
    required this.address,
    required this.cpf,
    required this.paymentTypeTd,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'data': data.toIso8601String(),
      'status': status.acronym,
      'products': orderProducts.map((x) => x.toMap()).toList(),
      'user_id': userId,
      'address': address,
      'cpf': cpf,
      'payment_method_id': paymentTypeTd,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as int,
      data: DateTime.parse(map['date']),
      status: OrderStatus.parse(map['status']),
      orderProducts: List<OrderProductModel>.from(
        (map['products']).map<OrderProductModel>(
          (x) => OrderProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      userId: int.parse(map['user_id']),
      address: map['address'] as String,
      cpf: map['CPF'].toString(),
      paymentTypeTd: map['payment_method_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
