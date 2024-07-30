import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Support extends StatelessWidget {
const Support({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFF1A3636),
      appBar: AppBar(
        title: "Support".text.make(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: "Contact the owner of this app".text.xl2.white.makeCentered(),
    );
  }
}