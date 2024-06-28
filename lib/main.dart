import 'package:flutter/material.dart';
import 'package:flutter_mahjong_yakuguide/buCalculator.dart';
import 'package:flutter_mahjong_yakuguide/handGenerator.dart';
import 'package:flutter_mahjong_yakuguide/variable.dart';
import 'package:flutter_mahjong_yakuguide/yakuCategorizer.dart';
import 'handGenerator.dart';

var handClass = handGenerator();

void main() {
  runApp(const MyApp());
  for (int k = 0; k < 1500; k++) {
    handClass.init();
    handClass.result_map['부수'] = buCalculator(handClass.result_map, handClass.menzen);
    yakuCategorizer(handClass.result_map, handClass.body);
  }

  // 변수 파일 하나 만들어서 거기서 변수 관리하기
  // 메인에는 앱기동에 관련한 것만 넣어놓기 
  print(a);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    handClass.init();

    

    setState(() {
      _counter++;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
