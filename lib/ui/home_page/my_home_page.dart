import 'package:calculator/ui/home_page/component/button.dart';
import 'package:calculator/ui/history/history.dart';
import 'package:calculator/ui/history/history_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userInput= '';
  var userOutput='';
  
  
  String input = '';
  String output = '';
  final List<String> buttons = [
    'C', 'DEL', '%', '÷',
    '9', '8', '7', 'X',
    '6', '5', '4', '–',
    '3', '2', '1', '+',
    '0', '.', 'ANS', '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Input
          Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => History(),));
                      }, icon: const Icon(Icons.history)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(userOutput,style: GoogleFonts.lora(fontSize: 40,fontWeight:FontWeight.w500,color:const Color(0XFF0087F3)),),
                          Text(userInput,style: GoogleFonts.barlow(fontSize: 25,fontWeight:FontWeight.w400,color:Colors.black.withOpacity(0.5)),),
                        ],

                      ),
                    ],
                  ),
                ),
              )),
          
          //Buttons
          Expanded(
            flex: 3,
            child: GridView.builder(
              physics:const NeverScrollableScrollPhysics(),
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0 )  {
                    return Button(
                      press: (){
                        setState(() {
                          userInput = '';
                          userOutput ='';
                        });
                      },
                      text: buttons[index],

                      //color: Color(0xFFE8F5E9),
                     // color: Color(0xFFC8E6C9),
                      color: Colors.green,
                      textColor: Colors.white,
                      fontWeight: isOperator(buttons[index])
                          ? FontWeight.w900
                          : FontWeight.w400,
                    );
                  } else if (index == 1) {
                    return Button(
                      press: (){
                        setState(() {
                          userInput=userInput.substring(0,userInput.length-1);
                        });
                      },
                      text: buttons[index],
                      //color: Color(0xFFFFCDD2),
                      color: Colors.red,
                      textColor: Colors.white,
                      fontWeight: isOperator(buttons[index])
                          ? FontWeight.w900
                          : FontWeight.w400,
                    );
                  } else if (index == buttons.length-1) {
                    return Button(
                      press: (){
                        setState(() {
                          equalPressed();
                          input = userInput;
                          output = userOutput;
                          infoList.add(HistoryInfo(input: input,result: output));
                        });
                      },
                      text: buttons[index],
                      color: const Color(0XFFF9FBFF),
                      textColor: isOperator(buttons[index])
                          ? const Color(0XFF0087F3)
                          : Colors.black,
                      fontWeight: isOperator(buttons[index])
                          ? FontWeight.w900
                          : FontWeight.w400,
                    );
                  } else if (index == buttons.length-2) {
                    return Button(
                      press: (){
                        setState(() {
                          equalPressed();
                          input = userInput;
                          output = userOutput;
                          infoList.add(HistoryInfo(input: input,result: output));
                        });
                      },
                      text: buttons[index],
                      color: const Color(0XFFF9FBFF),
                      textColor: isOperator(buttons[index])
                          ? const Color(0XFF0087F3)
                          : Colors.black,
                      fontWeight: isOperator(buttons[index])
                          ? FontWeight.w900
                          : FontWeight.w400,
                    );
                  }

                  else {
                    return Button(
                      press: (){
                        setState(() {
                          userInput = userInput+buttons [index];
                        });
                      },
                      text: buttons[index],
                      color: const Color(0XFFF9FBFF),
                      textColor: isOperator(buttons[index])
                          ? const Color(0XFF0087F3)
                          : Colors.black,
                      fontWeight: isOperator(buttons[index])
                          ? FontWeight.w900
                          : FontWeight.w400,
                    );
                  }
                }),
          )
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '÷' || x == 'X' || x == '–' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }
  void equalPressed(){
    String finalQuestion = userInput;
    finalQuestion = finalQuestion.replaceAll('X', '*');
    finalQuestion = finalQuestion.replaceAll('–', '-');
    finalQuestion = finalQuestion.replaceAll('ANS', '=');
    finalQuestion = finalQuestion.replaceAll('÷', '/');


    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    //userOutput = eval.toString();
    userOutput = eval.toStringAsFixed(eval.truncateToDouble()== eval? 0:2).toString();
  }
}
// return eval.toStringAsFixed(eval.truncateToDouble() == eval ? 0 : 2).toString();