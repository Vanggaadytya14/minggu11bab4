import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minggu11bab4/widgets/button.dart';
import 'package:minggu11bab4/widgets/dropdown.dart';
import 'package:minggu11bab4/widgets/history.dart';
import 'package:minggu11bab4/widgets/result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Konverter Suhu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controllerCelcius = TextEditingController();
  double _currentSliderValue = 0;
  //variabel berubah
  double _inputCelcius = 0;
  double _result = 0;
  //tambahkan variabel lain yang dibutuhkan
  var jenisSuhu = ["Kelvin", "Reamur"];
  var selectedSuhu = "Kelvin";
  List<String> history = <String>[];

  setSelectedSuhu(String value) {
    setState(() {
      selectedSuhu = value.toString();
    });
  }

  konverterSuhu() {
    setState(() {
      if (_controllerCelcius.text.isNotEmpty) {
        _inputCelcius = double.parse(_controllerCelcius.text);
        if (selectedSuhu == "Kelvin") {
          _result = _inputCelcius + 273;
        }
        if (selectedSuhu == "Reamur") {
          _result = _inputCelcius * 0.8;
        }

        history.add("$selectedSuhu : $_result");
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controllerCelcius.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            Slider(
              value: _currentSliderValue,
              max: 100,
              divisions: 10,
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                  _controllerCelcius.text = _currentSliderValue.toString();
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: ("Masukkan Suhu Dalam Celcius"), //hint text
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              controller: _controllerCelcius,
            ),
            DropdownSuhu(
                jenisSuhu: jenisSuhu,
                selectedSuhu: selectedSuhu,
                setSelectedSuhu: setSelectedSuhu),
            ResultKonversi(
              result: _result,
            ),
            ButtonKonversi(konversi: konverterSuhu),
            const Text(
              "Riwayat Konversi",
              style: TextStyle(fontSize: 20),
            ),
            History(history: history)
          ],
        ),
      ),
    );
  }
}
