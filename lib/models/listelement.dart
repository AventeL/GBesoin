import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ListElement extends StatelessWidget {
  final String text;
  final int index;

  const ListElement(
    this.text,
    this.index, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RoundedLoadingButtonController _btnController =
        RoundedLoadingButtonController();
    void _doSomething() async {
      Timer(const Duration(milliseconds: 700), () {
        _btnController.success();
      });
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          "-  " + text.toUpperCase(),
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        RoundedLoadingButton(
          width: 45,
          height: 45,
          color: Colors.green,
          child: const Icon(Icons.shopping_cart),
          controller: _btnController,
          onPressed: _doSomething,
        )
      ]),
    );
  }
}
