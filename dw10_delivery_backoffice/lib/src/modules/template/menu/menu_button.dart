import 'package:flutter/material.dart';

import '../../../core/ui/styles/text_styles.dart';
import 'menu_enum.dart';

class MenuButton extends StatelessWidget {
  final Menu menu;
  final Menu? menuSelected;
  final ValueChanged<Menu> onPressed;

  const MenuButton({
    required this.menu,
    this.menuSelected,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = menuSelected == menu;

    return LayoutBuilder(
      builder: (_, constraints) {
        return Visibility(
          visible: constraints.maxWidth != 90,
          replacement: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            decoration: isSelected
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFFFF5E2),
                  )
                : null,
            child: Tooltip(
              message: menu.label,
              child: IconButton(
                icon: Image.asset(
                  'assets/images/icons/${isSelected ? menu.asstIconSelected : menu.assetIcon}',
                ),
                onPressed: () => onPressed(menu),
              ),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => onPressed(menu),
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                decoration: isSelected
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFFFF5E2),
                      )
                    : null,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        'assets/images/icons/${isSelected ? menu.asstIconSelected : menu.assetIcon}',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Text(
                        menu.label,
                        overflow: TextOverflow.ellipsis,
                        style: isSelected
                            ? context.textStyles.textBold
                            : context.textStyles.textRegular,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
