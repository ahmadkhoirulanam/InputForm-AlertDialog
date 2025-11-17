import 'package:flutter/material.dart';
import 'package:navigator_5d/beranda.dart';

void main() {
  runApp(const MyApp());
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
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Appbar"), backgroundColor: Colors.blue),
      body: Column(
        children: [
          Text("halaman body"),
          Image(image: AssetImage('assets/images/upgris.png'), height: 300),
          Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTINHQbi0SDqufqSHr8F49auQ_SLVV7vBG3FQ&s', width: 200,),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Halaman_Utama()),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text("Pindah"),
          ),
        ],
      ),
    );
  }
}
