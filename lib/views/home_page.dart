import 'package:calculator/components/holder.dart';
import 'package:calculator/components/seed_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:calculator/components/seed_color.dart';
import 'package:flutter/rendering.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:typethis/typethis.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final scrollDirection = Axis.vertical;

  String equation = "0";
  String result = "";
  String expression = "";
  double equationSize = 52.2;
  double resultSize = 20;
  Color resultColor = Colors.white;
  Color expressionColor = Colors.white70;
  String ans = "";
  bool _isDarkMode = true;
  bool isReverse = true;
  bool showAnswerBtn = true;

  void _toggleTheme(bool newValue) {
    setState(() {
      _isDarkMode = newValue;
    });
  }

  Map<String, String> history = {};

  // Function to add new entries to the map
  void addEntry(String equation, String result) {
    setState(() {
      history[equation] = result;
    });
  }

  // Function to check if the map is empty
  bool isEmpty() {
    return history.isEmpty;
  }

  String? calculateExpression(String expression) {
    try {
      ContextModel context = ContextModel();
      Expression exp = Parser().parse(expression); // Use Parser().parse
      String result = exp.evaluate(EvaluationType.REAL, context).toString();
      // return result.toString();
      // Check for trailing ".0" and trim if necessary
      return result = result.endsWith(".0")
          ? result.substring(0, result.length - 2)
          : result;
    } catch (e) {
      return 'Error';
    }
  }

  buttonPressed(String buttonText) {
    isReverse = true;
    // reduce the length of text when it passes a certain limit
    int size1 = (MediaQuery.of(context).size.width / 37.5).toInt();
    int size2 = (MediaQuery.of(context).size.width / 37.5 + size1*0.61).toInt();
    int size3 = (MediaQuery.of(context).size.width / 37.5 + size1*1.61).toInt();
     int size4 = (MediaQuery.of(context).size.width / 37.5 + size1*2.61).toInt();
print("$size1, $size2 $size3 $size4");
    setState(() {
      //reset scroll position
      // scrollToStart();
      scrollToPage1();
      // this sections determines what happens when a button is pressed
      if (buttonText == "C") {
        // change font size to show focus and hierachy
        equationSize = 52.2;
        resultSize = 20;
        // swapp color to show where the focus is at
        expressionColor = Colors.white;
        resultColor = Colors.white70;
        // clear all the characters
        result = '';
        expression = "";
        equation = "0";
        print("clear screen");
      } else if (buttonText == "␡") {
        isReverse = true;
        try {
          // change font size to show focus and hierachy
          equationSize = 52.2;
          if (expression.length >= size1) equationSize = 52.2;
        if (expression.length >= size2) equationSize = 36;
        if (expression.length >= size3) equationSize = 30;
        if (expression.length >= size4) equationSize = 28;

          resultSize = 20;
          // swapp color to show where the focus is at
          expressionColor = Colors.white;
          resultColor = Colors.white70;
          // delete if the word is Error
          if (expression == "Error") {
            expression = '';
            equation = '0';
            result = '';
          }
          // delete previos character
          int index = expression.length - 1;
          expression = expression.substring(0, index);
          result = '';
          if (expression.length == 0) {
            equation = "0";
            return;
          }
          String temp = expression.trim();
          temp = temp.replaceAll('x', '*');
          temp = temp.replaceAll('÷', '/');
          temp = temp.replaceAll('%', '*1/100');
          print(temp);
          String temp2 = calculateExpression(temp).toString();
          if (temp2 != 'Error') {
            result = temp2;
          }
          equation = expression;
        } catch (err) {
          print('Screen is clear');
          equation = "0";
        }
      } else if (buttonText == "＝") {
        // reset size of the result text
        resultSize = 52.2;
       if (result.length >= size1) resultSize = 48;
        if (result.length >= size2) resultSize = 36;
        if (result.length >= size3) resultSize = 30;
        if (result.length >= size4) resultSize = 28;

        isReverse = false;
        equationSize = 20;
        // resultSize = 52.2;
        print(expression);
        // swapp color to show where the focus is at
        resultColor = Colors.white;
        expressionColor = Colors.white70;
        // calculte for results
        String temp = expression.trim();
        temp = temp.replaceAll('x', '*');
        temp = temp.replaceAll('÷', '/');
        temp = temp.replaceAll('%', '*1/100');
        print(temp);
        result = calculateExpression(temp).toString();
        // swap expression and result
        /*expression = result;*/

        // result = '0.0';
        // Handle submission of equation (e.g., calculate result)
        // Replace with actual calculation
        if (result != 'Error') {
          // store result in history map
          addEntry(equation, result);
          // store result in Ans variable
          ans = result;
          print(result);
        }
      } else {
        // change font size to show focus and hierachy
        equationSize = 52.2;
        if (expression.length >= size1) equationSize = 48;
        if (expression.length >= size2) equationSize = 36;
        if (expression.length >= size3) equationSize = 30;
        if (expression.length >= size4) equationSize = 28;

        // equationSize = 52.2;

        resultSize = 20;
        // swapp color to show where the focus is at
        expressionColor = Colors.white;
        resultColor = Colors.white70;
        // update the screen with buttonText
        expression = expression + buttonText;
        equation = expression;
        // the autocalculate section of the code
        String temp = expression.trim();
        temp = temp.replaceAll('x', '*');
        temp = temp.replaceAll('÷', '/');
        temp = temp.replaceAll('%', '*1/100');
        print(temp);
        String temp2 = calculateExpression(temp).toString();
        print(temp2);
        if (temp2 != 'Error') {
          result = temp2;
        }
      }
    });
  }

  CustomBtn(
      // Color? buttonColor2 ,
      {
    required String buttonText,
    required double buttonHeight,
    required Color buttonColor,
    Color? buttonColor2 = Colors.transparent,
  }) {
    // buttonColor2 = Colors.transparent;
    var isTapped = false;
    return InkWell(
      radius: buttonHeight / 2,
      borderRadius: BorderRadius.circular(buttonHeight / 3),
      // behavior: HitTestBehavior.deferToChild,
      onTap: () => buttonPressed(buttonText),
      child: Container(
          // padding: EdgeInsets.all(16),
          margin: const EdgeInsets.all(0.5),
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.1025 * buttonHeight,
          decoration: BoxDecoration(
            color: isTapped
                ? ThemeData.dark().canvasColor.withOpacity(0.8)
                : buttonColor2,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(buttonText,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w400,
                color: isTapped
                    ? ThemeData.dark().canvasColor.withOpacity(0.8)
                    : buttonColor,
              ))),
    );
  }

  // scroll controller
  /*AutoScrollController controller = AutoScrollController();*/

  // Sample list of items
  final List<String> items = List.generate(50, (index) => "Item ${index + 1}");

  // scroll controller
  final ScrollController _scrollController = ScrollController();
  final PageAutoScrollController _pageScrollController =
      PageAutoScrollController();

  // scroll to index method
  /* Future _scrollToIndex() async {
    await controller.scrollToIndex(1, preferPosition: AutoScrollPosition.end);
  }*/

  // scroll to start
  void scrollToStart() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent, // Scroll position at the end
      duration: Duration(milliseconds: 100), // Animation duration
      curve: Curves.ease, // Animation curve
    );
  }

  void scrollToPage1() {
    _pageScrollController.animateTo(0.0, // scroll to top page
        duration: Duration(milliseconds: 100),
        curve: Curves.bounceIn);
  }
/*
  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
      // viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, 0),
      axis: scrollDirection,
    );
  }*/

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double? indent = MediaQuery.of(context).size.width -
        (MediaQuery.of(context).size.width * 0.57);
    return Scaffold(
      key: _globalKey,
      backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
      appBar: AppBar(
          scrolledUnderElevation: 0,
          elevation: 0,
          forceMaterialTransparency: true,
          shadowColor: Colors.black,
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
          title: _customAppBar(_globalKey)),
      // bottomSheet: BottomSheet(onClosing: (){}, builder: ),

      body: Column(
        children: [
          // App bar
          // Padding(
          // padding: EdgeInsets.fromLTRB(15, 15, 10, 3),
          // child: _customAppBar(_globalKey)),
          // cupertino
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
                  decoration: BoxDecoration(
                    color: ThemeData.dark().focusColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Container(
                    // padding: EdgeInsets.all(4),
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.fromLTRB(1, 0, 1, 5),

                    decoration: BoxDecoration(
                      color: ThemeData.dark()
                          .scaffoldBackgroundColor
                          .withOpacity(0.85),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: PageView(
                      onPageChanged: (pageNumber) {
                        setState(() {
                          print(pageNumber);
                          if (pageNumber == 1) {
                            showAnswerBtn = false;
                            scrollToStart();
                          } else
                            showAnswerBtn = true;
                        });
                      },
                      controller: _pageScrollController,
                      // scrollDirection: Axis.vertical,
                      scrollBehavior: MaterialScrollBehavior(),
                      children: [
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 10, 5),
                              child: _ResultEquationDisplay(context),
                            )),
                        _historyContainer()
                      ],
                    ),
                    // child: _ResultEquationDisplay(context),
                  ),
                ),
                if (showAnswerBtn) _answerButton(context)
              ],
            ),
          ),
          // Expanded(
          //         child: Divider(
          //           thickness: 2,
          //           indent: indent,
          //           endIndent: indent,
          //           color: ThemeData.dark().dividerColor,
          //         ),
          //       ),
          Container(
            alignment: Alignment.center,
            // padding:
            // const EdgeInsets.only(bottom: 2, top: 1, right: 1, left: 1),
            decoration: const BoxDecoration(
                // color: ThemeData.dark().cardColor,
                color: Colors.black26,
                // borderRadius: BorderRadius.circular(50),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 6,
                    // width: MediaQuery.of(context).size.width * 0.75,
                    child: Table(
                      children: [
                        TableRow(children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 2, 0),
                            child: CustomBtn(
                              buttonColor: Colors.white,
                              buttonColor2: Colors.blue.withOpacity(0.4),
                              buttonHeight: 1,
                              buttonText: 'C',
                            ),
                          ),
                          CustomBtn(
                            buttonColor: seed,
                            buttonHeight: 1,
                            buttonText: '÷',
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
                            buttonText: '%',
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
                    flex: 2,
                    // width: MediaQuery.of(context).size.width * 0.30,
                    child: Table(
                      children: [
                        TableRow(children: [
                          CustomBtn(
                            buttonColor: seed,
                            buttonHeight: 1,
                            buttonText: '␡',
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
                            buttonHeight: 1,
                            buttonText: '+',
                          ),
                        ]),
                        TableRow(children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: CustomBtn(
                              buttonColor2: Color.fromARGB(255, 78, 212, 83),
                              buttonColor: Colors.white,
                              buttonHeight: 2,
                              buttonText: '＝',
                            ),
                          )
                        ]),
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        key: _globalKey,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.white70,
        child: Container(
          padding: EdgeInsets.only(top: 20, bottom: 40),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.75,
          color: Colors.black87,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(color: Colors.blue, height: 70),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(color: Colors.blue, height: 70),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(color: Colors.blue, height: 70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Positioned _answerButton(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.0,
      right: MediaQuery.of(context).size.width * 0.80,
      // left: double.minPositive,
      left: MediaQuery.of(context).size.width * 0.025,
      top: MediaQuery.of(context).size.width * 0.05,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: FloatingActionButton.extended(
                // label: Text('previous save'),
                shape: CircleBorder(),
                backgroundColor: ThemeData.dark().focusColor.withOpacity(0.1),
                enableFeedback: true,
                onPressed: () {
                  setState(() {
                    isReverse = true;
                    // change font size to show focus and hierachy
                    equationSize = 52.2;
                    resultSize = 20;
                    // swapp color to show where the focus is at
                    expressionColor = Colors.white;
                    resultColor = Colors.white70;
                    //reset position of listview
                    // scrollToStart();
                    scrollToPage1();
                    // stores the preivious answer
                    if (ans == '') {
                      return;
                    }
                    expression = expression + ans;
                    String temp = expression;
                    equation = temp;
                  });
                },
                label: Text(
                  'Ans',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w400),
                )),
          ),
        ],
      ),
    );
  }

  ListView _ResultEquationDisplay(BuildContext context) {
    return ListView(
      primary: false,
      // controller: _scrollController,
      scrollDirection: scrollDirection,
      dragStartBehavior: DragStartBehavior.down,
      physics:
          BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
      shrinkWrap: true,
      reverse: isReverse,
      // mainAxisAlignment: MainAxisAlignment.end,
      children: [
        isReverse
            ? Container(
                // height: 150,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
                child: IntrinsicWidth(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          flex: 1,
                          child: Text(
                            '=',
                            style: TextStyle(color: Colors.white54),
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex:
                            (MediaQuery.of(context).size.width * 0.90).toInt(),
                        child: Text(result,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: resultSize,
                                color: resultColor)),
                      ),
                    ], //calculatorPage
                  ),
                ),
              )
            : AutoSizeText(result,
                minFontSize: 38,
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: resultSize,
                    color: resultColor)),

        // SizedBox(height: 15,),
        // LinearProgressIndicator(minHeight: 0.025,),

        Container(
          // height: 10,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(
              15, MediaQuery.of(context).size.height * 0.03, 15, 5),
          child: Text(equation,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: equationSize,
                  color: expressionColor)),
        ),
        // _historyContainer(),
      ],
    );
  }

  Container _historyContainer() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),

      // Display the map contents
      child: isEmpty()
          ? Text('No entries yet...', style: TextStyle(color: Colors.white))
          : ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              // reverse: true,
              controller: _scrollController,
              itemCount: history.length,
              itemBuilder: (context, index) {
                String equation = history.keys.elementAt(index);
                String result = history.values.elementAt(index);
                return ListTile(
                  contentPadding: EdgeInsets.all(10),
                  title: Text(
                    equation,
                    // textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  subtitle: Text(
                    '\t= ' + result,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                        color: Colors.white54),
                  ),
                );
              },
            ),
    );
  }

  Row _customAppBar(_globalKey) {
    return const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      // IconButton(onPressed: () {print('dont touch me sir...');}, icon: Icon(Icons.menu_rounded, color: Colors.white),),
      TypeThis(
          string: 'C  A  L  C  U  L  A  T  O  R',
          speed: 30,
          style: TextStyle(
              fontFamily: String.fromEnvironment("poppins"),
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white)),
      //  Switch(
      //         value: _isDarkMode,
      //         onChanged: _toggleTheme, // Function to toggle theme mode
      //       ),
      // IconButton(
      //     onPressed: () => _globalKey.currentState!.openDrawer,
      //     // Scaffold.of(context).openDrawer(),
      //     icon: Icon(CupertinoIcons.settings_solid, color: Colors.white))
    ]);
  }
}

// class CustomBtn extends StatelessWidget {
//   const CustomBtn({
//     super.key,
//     this.buttonText = "String?",
//     this.buttonHeight = 1,
//     this.buttonColor,
//     this.isTapped = false,
//     this.buttonColor2 = Colors.transparent,
//   });
//   final String buttonText;
//   final double buttonHeight;
//   final Color? buttonColor;
//   final Color buttonColor2;
//   final bool isTapped;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       behavior: HitTestBehavior.translucent,
//       onTap: ()=> buttonPressed(buttonText),
//       child: Container(
//           // padding: EdgeInsets.all(16),
//           // margin: EdgeInsets.all(3),
//           alignment: Alignment.center,
//           height: MediaQuery.of(context).size.height * 0.11 * buttonHeight,
//           decoration: BoxDecoration(
//               color: isTapped
//                   ? ThemeData.dark().canvasColor.withOpacity(0.8)
//                   : buttonColor2.withOpacity(0.9),
//               // borderRadius: BorderRadius.circular(5),
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(5),
//                 bottomRight: Radius.circular(5),
//               ),
//               border: Border.all(
//                   width: 1, color: ThemeData.dark().backgroundColor)),
//           child: Text(buttonText,
//               style: TextStyle(
//                 fontSize: 34,
//                 color: isTapped
//                     ? ThemeData.dark().canvasColor.withOpacity(0.8)
//                     : buttonColor,
//               ))),
//     );
//   }
// }
