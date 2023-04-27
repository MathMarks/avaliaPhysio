import 'package:flutter/material.dart';
import 'dart:ffi';
import 'package:group_button/group_button.dart';

class InputRowHorizontal extends StatelessWidget {
  var parteDoCopro = "";

  List<int> values;

  InputRowHorizontal(this.values, this.parteDoCopro);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: Text(
              parteDoCopro,
              style: TextStyle(
                  fontSize: 20, letterSpacing: 2, fontWeight: FontWeight.w800),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Column(
                        children: [
                          Text(
                            "Direita",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          GroupButton(
                            options: GroupButtonOptions(
                                spacing: 0,
                                buttonWidth: 40,
                                unselectedBorderColor: Colors.blue[900]),
                            isRadio: true,
                            onSelected: (value, index, isSelected) =>
                                {values[0] = value},
                            buttons: [1, 2, 3, 4, 5],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "Esquerda",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        GroupButton(
                          options: GroupButtonOptions(
                              spacing: 0,
                              buttonWidth: 40,
                              unselectedBorderColor: Colors.blue[900]),
                          isRadio: true,
                          onSelected: (value, index, isSelected) =>
                              {values[1] = value},
                          buttons: [1, 2, 3, 4, 5],
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
