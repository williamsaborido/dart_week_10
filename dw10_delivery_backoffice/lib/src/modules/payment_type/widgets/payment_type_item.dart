import 'package:flutter/material.dart';

import '../../../core/ui/styles/text_styles.dart';
import '../../../models/payment_type_model.dart';
import '../payment_type_controller.dart';

class PaymentTypeItem extends StatelessWidget {
  final PaymentTypeController controller;
  final PaymentTypeModel payment;

  const PaymentTypeItem({
    required this.controller,
    required this.payment,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorAll = payment.enabled ? Colors.black : Colors.grey;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Image.asset(
              'assets/images/icons/payment_${payment.acronym}_icon.png',
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/icons/payment_notfound_icon.png',
                  color: colorAll,
                );
              },
              color: colorAll,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Text(
                      'Forma de pagamento',
                      style: context.textStyles.textRegular
                          .copyWith(color: colorAll),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FittedBox(
                    child: Text(
                      payment.name,
                      overflow: TextOverflow.ellipsis,
                      style: context.textStyles.textTitle
                          .copyWith(color: colorAll),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    controller.editPayment(payment);
                  },
                  child: Text(
                    'Editar',
                    style: context.textStyles.textMedium.copyWith(
                      color: payment.enabled ? Colors.green : colorAll,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
