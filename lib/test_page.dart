import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TestingPage extends StatelessWidget {
  const TestingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: const Icon(Iconsax.add),
        onPressed: () {
          dynamic time = DateTime.now();
          print(time.runtimeType);
          print(time);
          print('=================');
          dynamic time2 = DateTime.now().millisecondsSinceEpoch;
          print(time2.runtimeType);
          print(time2);
        },
      ),
    );
  }
}
