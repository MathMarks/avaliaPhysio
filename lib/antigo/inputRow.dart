import 'package:flutter/material.dart';

class InputRow extends StatelessWidget {
  var parteDoCopro = "";
  List<TextEditingController> controller;

  InputRow(this.controller, this.parteDoCopro, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(parteDoCopro),
          Container(
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SizedBox(
                    width: 100,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: controller[0],
                      decoration: InputDecoration(
                          hintText: "1-5",
                          labelText: "Esquerda",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          isDense: true),
                    ),
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    width: 100,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: controller[1],
                      decoration: InputDecoration(
                          hintText: "1-5",
                          labelText: "Direita",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          isDense: true),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
