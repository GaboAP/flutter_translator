import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class translator extends StatefulWidget {
  const translator({super.key});

  @override
  State<translator> createState() => _translatorState();
}

class _translatorState extends State<translator> {
  var languages = ['English', 'Spanish', 'French'];
  var originLanguage = "From";
  var destinationLanguage = "To";
  var output = "";
  TextEditingController languageController = TextEditingController();

  void translate(String src, String dest, String input) async {
    GoogleTranslator translator = new GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });
    if (src == '--' || dest == "--") {
      setState(() {
        output = "Error al traducir";
      });
    }
  }

  String getLanguageCode(String language) {
    switch (language) {
      case "English":
        return "en";

      case "Spanish":
        return "es";

      case "French":
        return "fr";

      default:
        return "--";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x0f0f0f),
      appBar: AppBar(
        title: Text("Traductor simple"),
        centerTitle: true,
        backgroundColor: Color(0x0f0f0f),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  focusColor: Colors.white,
                  iconDisabledColor: Colors.white,
                  iconEnabledColor: Colors.white,
                  hint: Text(originLanguage,
                      style: TextStyle(color: Colors.white)),
                  dropdownColor: Colors.white,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: languages.map((String dropDownStringItem) {
                    return DropdownMenuItem(
                        child: Text(dropDownStringItem),
                        value: dropDownStringItem);
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      originLanguage = value!;
                    });
                  },
                ),
                SizedBox(
                  width: 40,
                ),
                Icon(Icons.arrow_right_alt_outlined,
                    color: Colors.white, size: 40),
                SizedBox(
                  width: 40,
                ),
                DropdownButton(
                  focusColor: Colors.white,
                  iconDisabledColor: Colors.white,
                  iconEnabledColor: Colors.white,
                  hint: Text(destinationLanguage,
                      style: TextStyle(color: Colors.white)),
                  dropdownColor: Colors.white,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: languages.map((String dropDownStringItem) {
                    return DropdownMenuItem(
                        child: Text(dropDownStringItem),
                        value: dropDownStringItem);
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      destinationLanguage = value!;
                    });
                  },
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                cursorColor: Colors.white,
                autofocus: false,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Ingrese texto',
                    labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                    ),
                    errorStyle: TextStyle(color: Colors.red, fontSize: 15)),
                controller: languageController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese texto a traducir';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0x0f0f0f)),
                  onPressed: () {
                    translate(
                        getLanguageCode(originLanguage),
                        getLanguageCode(destinationLanguage),
                        languageController.text.toString());
                  },
                  child: Text("Traducir")),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "\n$output",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )
          ],
        )),
      ),
    );
  }
}
