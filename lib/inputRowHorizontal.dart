import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class InputRowHorizontal extends StatelessWidget {
  final parteDoCopro = "";

  List<int> values;

  InputRowHorizontal(this.values, parteDoCopro, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Text(
                parteDoCopro,
                style: const TextStyle(
                    fontSize: 20,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w800),
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
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Column(
                          children: [
                            const Text(
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
                              buttons: const [1, 2, 3, 4, 5],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          const Text(
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
                            buttons: const [1, 2, 3, 4, 5],
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
      ),
    );
  }
}
