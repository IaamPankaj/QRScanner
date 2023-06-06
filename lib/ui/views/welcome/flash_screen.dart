import 'package:flutter/material.dart';

class FlashScreen extends StatelessWidget {
  const FlashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
          child: Center(
        child: Icon(
          Icons.qr_code_2_rounded,
          size: 200,
        ),
      )),
    );
  }
}
