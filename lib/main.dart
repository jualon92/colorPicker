import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Elige tu color'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  Color? colorSeleccionado; //can be color or null


  final Map<String, Color> colores = {
    "naranja" : Colors.orange,
    "azul" : Colors.blue,
    "violeta" : Colors.purple,
    "rosado" : Colors.pinkAccent,
    "amarillo" : Colors.amberAccent
  };

  @override
  void initState(){
    _getColorGuardado(); //si hay un color elegido anteriorme guardado en memoria, deberia ser color inicial
    super.initState();

  }




    void _getColorGuardado() async{ //obtiene color en local
      SharedPreferences prefs = await SharedPreferences.getInstance(); //platform specific local storage
      String? nombreColor = prefs.getString("color"); //getter color local storage
      setState(() {
          colorSeleccionado = colores[nombreColor];
      });
    }

    void _setColor(String nombreColor, Color color) async { //updates states
      SharedPreferences prefs = await SharedPreferences.getInstance(); //platform specific local storage
      await prefs.setString("color", nombreColor); //guardar local
      setState(() { //setear color ui
        colorSeleccionado = color;
      });
    }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        //setter color barra
        title: Text(widget.title),
        backgroundColor: colorSeleccionado ?? Colors.black, //si no hay color seleccionado es negro
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, //centro eje y
        crossAxisAlignment: CrossAxisAlignment.stretch, // columna es eje y. cross es eje x. stretch largo pantalla

          children: [
            Center(
              child: Text(
      'Estas utilizando ${kIsWeb ? "la web" : Platform.operatingSystem}', // podria usarse if  isAndroid
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
              )),
          for (var entry in colores.entries) //por cada entrada de color
            Container( //agregar boton
              margin: const EdgeInsets.all(10),

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                primary: entry.value,
                minimumSize: const Size(300,60),
              ),
              child: const Text(""),
              onPressed: () => _setColor(entry.key, entry.value))
            )
        ]




      ),
         // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
