import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ListElement extends StatefulWidget {
  final String text;
  final int idGroup;
  final String reference;

  const ListElement({
    required this.text,
    Key? key,
    required this.idGroup,
    required this.reference,
  }) : super(key: key);

  @override
  State<ListElement> createState() => _ListElementState();
}

class _ListElementState extends State<ListElement> {
  List element = [];
  Color mainColor = const Color(0xff8D0008);
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void deleteElement(String reference) {
    setState(() {
      FirebaseFirestore.instance.collection('element').doc(reference).delete();
    });
  }

  void _onClick() async {
    Timer(const Duration(milliseconds: 900), () {
      _btnController.success();
      Timer(const Duration(milliseconds: 600), () {
        deleteElement(widget.reference);
        _btnController.reset();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          "-  " + widget.text.toUpperCase(),
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        RoundedLoadingButton(
          completionDuration: const Duration(milliseconds: 900),
          width: 40,
          color: Colors.white,
          elevation: 0,
          successColor: Colors.white,
          valueColor: mainColor,
          child: Icon(
            Icons.shopping_cart,
            color: mainColor,
          ),
          controller: _btnController,
          onPressed: _onClick,
        )
      ]),
    );
  }
}
