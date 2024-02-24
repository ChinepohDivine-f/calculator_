import 'package:calculator/components/holder.dart';
import 'package:calculator/components/seed_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calculator/components/seed_color.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    double? indent = MediaQuery.of(context).size.width -
        (MediaQuery.of(context).size.width * 0.57);
    return Scaffold(
      backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
      appBar: AppBar(
          bottomOpacity: 5,
          backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            // IconButton(onPressed: () {print('dont touch me sir...');}, icon: Icon(Icons.menu_rounded, color: Colors.white),),
            Text('C A L C U L A T O R',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white)),
            Switch(
              value: true,
              onChanged: (value) {},
            )
          ])),
      // appBar: AppBar(title: SliverAppBar(title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      //    Text('C A L C U L A T O R',
      //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
      //       Switch(value: true, onChanged: (value) {},)]))),
      body: Column(
        children: [
          // cupertino
          Expanded(
            flex: 8,
            child: ListView(
              shrinkWrap: true,
              reverse: true,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: Text('0',
                      style: TextStyle(fontSize: 48, color: Colors.white)),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: Text('0',
                      style: TextStyle(fontSize: 36, color: Colors.white60)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 2,
              indent: indent,
              endIndent: indent,
              color: ThemeData.dark().dividerColor,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding:
                const EdgeInsets.only(bottom: 2, top: 1, right: 1, left: 1),
            decoration: BoxDecoration(
                color: ThemeData.dark().cardColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex:3,
                    // width: MediaQuery.of(context).size.width * 0.75,
                    child: Table(
                      children: [
                        TableRow(children: [
                          CustomBtn(
                            buttonColor: Color.fromARGB(255, 230, 74, 71),
                            buttonHeight: 1,
                            buttonText: 'C',
                          ),
                          CustomBtn(
                            buttonColor: seed,
                            buttonHeight: 1,
                            buttonText: '/',
                          ),
                          CustomBtn(
                            buttonColor: seed,
                            buttonHeight: 1,
                            buttonText: 'x',
                          ),
                        ]),
                        TableRow(children: [
                          CustomBtn(
                            buttonColor: Colors.white,
                            buttonHeight: 1,
                            buttonText: '7',
                          ),
                          CustomBtn(
                            buttonColor: Colors.white,
                            buttonHeight: 1,
                            buttonText: '8',
                          ),
                          CustomBtn(
                            buttonColor: Colors.white,
                            buttonHeight: 1,
                            buttonText: '9',
                          ),
                        ]),
                        TableRow(children: [
                          CustomBtn(
                            buttonColor: Colors.white,
                            buttonHeight: 1,
                            buttonText: '4',
                          ),
                          CustomBtn(
                            buttonColor: Colors.white,
                            buttonHeight: 1,
                            buttonText: '5',
                          ),
                          CustomBtn(
                            buttonColor: Colors.white,
                            buttonHeight: 1,
                            buttonText: '6',
                          ),
                        ]),
                        TableRow(children: [
                          CustomBtn(
                            buttonColor: Colors.white,
                            buttonHeight: 1,
                            buttonText: '1',
                          ),
                          CustomBtn(
                            buttonColor: Colors.white,
                            buttonHeight: 1,
                            buttonText: '2',
                          ),
                          CustomBtn(
                            buttonColor: Colors.white,
                            buttonHeight: 1,
                            buttonText: '3',
                          ),
                        ]),
                        TableRow(children: [
                          CustomBtn(
                            buttonColor: Colors.white,
                            buttonHeight: 1,
                            buttonText: '00',
                          ),
                          CustomBtn(
                            buttonColor: Colors.white,
                            buttonHeight: 1,
                            buttonText: '0',
                          ),
                          CustomBtn(
                            buttonColor: Colors.white,
                            buttonHeight: 1,
                            buttonText: '.',
                          ),
                        ]),
                      ],
                    )),
                Expanded(
                    // width: MediaQuery.of(context).size.width * 0.24,
                    child: Table(
                  children: [
                    TableRow(children: [
                      CustomBtn(
                        buttonColor: seed,
                        buttonHeight: 1,
                        buttonText: 'D',
                      ),
                    ]),
                    TableRow(children: [
                      CustomBtn(
                        buttonColor: seed,
                        buttonHeight: 1,
                        buttonText: '-',
                      ),
                    ]),
                    TableRow(children: [
                      CustomBtn(
                        buttonColor: seed,
                        // buttonHeight: 1,
                        buttonText: '+',
                      ),
                    ]),
                    const TableRow(children: [
                      CustomBtn(
                        buttonColor2: Color.fromARGB(255, 78, 212, 83),
                        buttonColor: Colors.white,
                        buttonHeight: 2,
                        buttonText: '=',
                      ),
                    ]),
                  ],
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    super.key,
    this.buttonText = "String?",
    this.buttonHeight = 1,
    this.buttonColor,
    this.isTapped = false,
    this.buttonColor2 = Colors.transparent,
  });
  final String buttonText;
  final double buttonHeight;
  final Color? buttonColor;
  final Color buttonColor2;
  final bool isTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {},
      child: Container(
          // padding: EdgeInsets.all(16),
          // margin: EdgeInsets.all(3),
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.11 * buttonHeight,
          decoration: BoxDecoration(
              color: isTapped
                  ? ThemeData.dark().canvasColor.withOpacity(0.8)
                  : buttonColor2.withOpacity(0.9),
              // borderRadius: BorderRadius.circular(5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              border: Border.all(
                  width: 1, color: ThemeData.dark().backgroundColor)),
          child: Text(buttonText,
              style: TextStyle(
                fontSize: 32,
                color: isTapped
                    ? ThemeData.dark().canvasColor.withOpacity(0.8)
                    : buttonColor,
              ))),
    );
  }
}
