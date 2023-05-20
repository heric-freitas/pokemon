import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/rest_client/dio_rest_client.dart';

class CoreModule extends StatelessWidget {

  final Widget child;

  const CoreModule({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider(create: (_) => DioRestClient()),
        ],
        child: child,
      );
}
