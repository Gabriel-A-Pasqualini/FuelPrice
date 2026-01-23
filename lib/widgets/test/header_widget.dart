import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/icon/fuelprice_logo.png',
          width: 150,
        ),
        const SizedBox(width: 8),
        //const Text(
        //  "FuelPrice",
        //  style: TextStyle(
        //    fontSize: 20,
        //    fontWeight: FontWeight.bold,
        //  ),
        //),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {},
        ),
      ],
    );
  }
}
