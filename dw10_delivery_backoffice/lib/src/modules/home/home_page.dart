import 'package:flutter/material.dart';

import '../../core/env/env.dart';
import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';
import '../../core/ui/helpers/size_extensions.dart';
import '../../core/ui/styles/colors_app.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Loader, Messages {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Env.instance.get('backend_base_url'),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          'Width: ${context.screenWidth}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Container(
          color: context.colors.primary,
          width: context.percentWidth(.2),
          height: context.percentHeight(.2),
        ),
        Container(
          color: context.colors.secondary,
          width: context.percentWidth(.2),
          height: context.percentHeight(.2),
        )
      ],
    );
  }
}
