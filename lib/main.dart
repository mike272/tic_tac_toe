
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/ai_logic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int playerWinsCounter=0;
  int opponentWinsCOunter=0;
  int drawsCounter=0;
  int score=-1;
  var fields = List.filled(9, empty);

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Tic Tac Toe"),
      ),
      body: Row(
        children: [
          AspectRatio(
            aspectRatio:1,
            child: GridView.count(crossAxisCount: 3,
            children: [
            for(int i=0; i<9; i++)  InkWell(onTap: (){
              setState(() {
                fields[i]=player;
                runAI();
              });
            },
            child: Center(
              child: Text(fields[i])
              // child: Text(fields[i]==1?"X":fields[i]==2?"O":""),
            ),)
          ],
          ),),
          Column(
            children: [
              Text(score==100?"You won":score==-100?"You Lost":"Your turn"),
              OutlinedButton(onPressed: (){
                setState(() {
                  fields = List.filled(9, empty);
                  // drawsCounter=0;
                  // playerWinsCounter=0;
                  // opponentWinsCOunter=0;
                });
              }, child: Text("Reset")),
              Text("Player score: ${playerWinsCounter}"),
              Text("AI score: ${opponentWinsCOunter}"),
              Text("Draws: ${drawsCounter}"),
              OutlinedButton(onPressed: (){
                setState(() {
                  drawsCounter=0;
                  playerWinsCounter=0;
                  opponentWinsCOunter=0;
                });
              }, child: Text("Reset Counters")),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void runAI() async {
    await Future.delayed(Duration(milliseconds: 200));
    int move = findBestMove(fields);
    setState(() {
      fields[move]=opponent;
    });
    int score = findWinningCondition(fields);
      setState(() {
        if(score==100){
          opponentWinsCOunter++;
        }else if(score==-100){
          playerWinsCounter++;
        }
        // if(!ArePossibleMovesLeft(fields)){
        //   drawsCounter++;
        // }
      });
  }
}

