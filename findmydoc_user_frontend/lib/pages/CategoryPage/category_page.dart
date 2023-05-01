import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        toolbarOpacity: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
