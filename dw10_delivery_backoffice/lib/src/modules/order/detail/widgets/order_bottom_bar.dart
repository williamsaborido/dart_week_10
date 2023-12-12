import 'package:flutter/material.dart';

import '../../../../core/ui/styles/text_styles.dart';

class OrderBottomBar extends StatelessWidget {
  const OrderBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        OrderBottomBarButton(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          buttonColor: Colors.blue,
          buttonLabel: 'Finalizar',
          image: 'assets/images/icons/finish_order_white_ico.png',
        ),
        OrderBottomBarButton(
          borderRadius: BorderRadius.zero,
          buttonColor: Colors.green,
          buttonLabel: 'Confirmar',
          image: 'assets/images/icons/confirm_order_white_icon.png',
        ),
        OrderBottomBarButton(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          buttonColor: Colors.red,
          buttonLabel: 'Cancelar',
          image: 'assets/images/icons/cancel_order_white_icon.png',
        ),
      ],
    );
  }
}

class OrderBottomBarButton extends StatelessWidget {
  final BorderRadius borderRadius;
  final Color buttonColor;
  final String image;
  final String buttonLabel;

  const OrderBottomBarButton({
    required this.borderRadius,
    required this.buttonColor,
    required this.image,
    required this.buttonLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
            side: BorderSide(color: buttonColor),
            backgroundColor: buttonColor,
          ),
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(image),
              const SizedBox(
                width: 5,
              ),
              Text(
                buttonLabel,
                style: context.textStyles.textMedium.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
