import 'package:flutter/material.dart';

import '../../../core/ui/widgets/base_header.dart';
import '../../../models/orders/order_status.dart';

class OrderHeader extends StatefulWidget {
  const OrderHeader({super.key});

  @override
  State<OrderHeader> createState() => _OrderHeaderState();
}

class _OrderHeaderState extends State<OrderHeader> {
  OrderStatus? selected;

  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: 'Administrar Pedidos',
      addButton: false,
      filterWidget: DropdownButton<OrderStatus>(
        value: selected,
        items: [
          const DropdownMenuItem(
            value: null,
            child: Text('Todos'),
          ),
          ...OrderStatus.values.map(
            (status) => DropdownMenuItem(
              value: status,
              child: Text(status.name),
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            selected = value;
          });
        },
      ),
    );
  }
}
