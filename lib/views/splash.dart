import 'dart:async';

import 'package:calculator/components/seed_color.dart';
import 'package:calculator/views/home_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});  

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CalculatorPage()));
    });

    initState() {
      super.initState();
    }
    Color color1 = Colors.black87;
    Color color2 = Colors.white;
    bool isShadow = true;

    // Timer(const Duration(seconds: 3), () {

    //   setState(() {
    //      Color temp = color1; 
    //      color1 = color2;
    //       color2 = temp;
    //   isShadow = false;
    //   });
     
    // });
    return Scaffold(
        backgroundColor: ColorScheme.fromSeed(seedColor: seed).background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  _LogoPhase1(color1, color2, isShadow),
                  // _LogoPhase1(),
                  const SizedBox(height: 15),
                  Text(
                    "Calculator",
                    style: TextStyle(
                        color:
                            ColorScheme.fromSeed(seedColor: seed).onBackground),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircularProgressIndicator.adaptive(
                    backgroundColor:
                        ColorScheme.fromSeed(seedColor: seed).background,
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Container _LogoPhase1(Color Color1, Color Color2, bool Shadow) {
    return Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            color: Color1,
            borderRadius: BorderRadius.circular(5),
            boxShadow: Shadow? [BoxShadow(
                color: Color1,
                offset: Offset(-2, -2), blurRadius: 10,
              ),
            
              BoxShadow(
                color: Color2,
                offset: Offset(5, 5), blurRadius: 20,
              ),
              
            ] : [],
            // border: Border.all(
            //     color: Color2)
            ),
        child: Center(
            child: Text(
          "=",
          style: TextStyle(
              fontSize: 65,
              color: Color2),
        )));
  }
}
