import 'package:flutter/material.dart';

import '../../../core/extensions/formatter_extensions.dart';
import '../../../core/ui/helpers/size_extensions.dart';
import '../../../core/ui/styles/text_styles.dart';
import 'widgets/order_bottom_bar.dart';
import 'widgets/order_info_tile.dart';
import 'widgets/order_product_item.dart';

class OrderDetailModal extends StatefulWidget {
  const OrderDetailModal({super.key});

  @override
  State<OrderDetailModal> createState() => _OrderDetailModalState();
}

class _OrderDetailModalState extends State<OrderDetailModal> {
  void closeModal() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;

    return Material(
      color: Colors.black26,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        backgroundColor: Colors.white,
        elevation: 10,
        child: Container(
          width: screenWidth * (screenWidth >= 1200 ? .5 : .7),
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Detalhes do pedido',
                        style: context.textStyles.textTitle,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: closeModal,
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Nome do cliente:',
                      style: context.textStyles.textBold,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Nome do cliente:',
                      style: context.textStyles.textRegular,
                    ),
                  ],
                ),
                ...List.generate(3, (index) => index)
                    .map((e) => OrderProductItem())
                    .toList(),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total do pedido:',
                        style: context.textStyles.textExtraBold
                            .copyWith(fontSize: 18),
                      ),
                      Text(
                        100.0.currencyPTBR,
                        style: context.textStyles.textExtraBold
                            .copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const OrderInfoTile(
                  label: 'Endereço de entrega:',
                  info: 'Av. Paulista, 200',
                ),
                const Divider(),
                const OrderInfoTile(
                  label: 'Forma de pagamento:',
                  info: 'cartão de crédito',
                ),
                const SizedBox(
                  height: 10,
                ),
                const OrderBottomBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
