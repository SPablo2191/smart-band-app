import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:smartband/src/models/school_model.dart';
import 'package:smartband/src/providers/school_provider.dart';

class RegisterStep2Page extends StatefulWidget {
  const RegisterStep2Page({super.key});

  @override
  State<RegisterStep2Page> createState() => _RegisterStep2PageState();
}

class _RegisterStep2PageState extends State<RegisterStep2Page> {
  String _name = '';
  String _DNI = '';
  String _lastName = '';
  List<School> schools = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
            child: Text(
          'Registrarse',
          style: TextStyle(color: Color.fromRGBO(29, 53, 87, 1), fontSize: 30),
        )),
        backgroundColor: Colors.white,
      ),
      body: ListView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          children: [
            Container(height: 50),
            _getDNI(),
            Container(
              height: 15,
            ),
            _getName(),
            Container(
              height: 15,
            ),
            _getLastName(),
            Container(
              height: 15,
            ),
            _getSchools(),
            Container(
              height: 40,
            ),
            _getButton('Siguiente', Color.fromRGBO(29, 53, 87, 1), context,
                'register/step2'),
            Container(
                margin: EdgeInsets.only(top: 46.0),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: '¿Ya tienes cuenta? ',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Inicia Sesión',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Color.fromRGBO(230, 57, 70, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )))
          ]),
    );
  }

  _getDNI() {
    return TextField(
      onChanged: (value) => setState(() {
        _DNI = value;
      }),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        iconColor: Color.fromRGBO(29, 53, 87, 1),
        labelStyle: TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        floatingLabelStyle: TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        hintStyle: TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        fillColor: Color.fromRGBO(221, 245, 246, 1),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Color.fromRGBO(29, 53, 87, 1))),
        labelText: 'DNI',
        helperText: '9 caracteres maximo',
        prefixIcon: Icon(Icons.perm_identity),
      ),
    );
  }

  _getName() {
    return TextField(
      onChanged: (value) => setState(() {
        _name = value;
      }),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        iconColor: Color.fromRGBO(29, 53, 87, 1),
        labelStyle: TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        floatingLabelStyle: TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        hintStyle: TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        fillColor: Color.fromRGBO(221, 245, 246, 1),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Color.fromRGBO(29, 53, 87, 1))),
        labelText: 'Nombre',
        prefixIcon: Icon(Icons.perm_identity),
      ),
    );
  }

  _getLastName() {
    return TextField(
      onChanged: (value) => setState(() {
        _lastName = value;
      }),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        iconColor: Color.fromRGBO(29, 53, 87, 1),
        labelStyle: TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        floatingLabelStyle: TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        hintStyle: TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        fillColor: Color.fromRGBO(221, 245, 246, 1),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Color.fromRGBO(29, 53, 87, 1))),
        labelText: 'Apellido',
        prefixIcon: Icon(Icons.perm_identity),
      ),
    );
  }

  _getButton(String label, color, BuildContext context, String route,
      {borderColor = Colors.white, textColor = Colors.white}) {
    return ElevatedButton(
      onPressed: () => {Navigator.pushNamed(context, route)},
      child: Text(
        label,
        style: TextStyle(fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        minimumSize: Size(250, 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: borderColor, width: 1.0)),
      ),
    );
  }

  _getSchools() {
    final SchoolProvider schoolProvider = SchoolProvider();
    return FutureBuilder(
      future: schoolProvider.getSchools(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final _items = snapshot.data
              ?.map((school) =>
                  MultiSelectItem<School?>(school, school.name ?? ''))
              .toList() as List<MultiSelectItem<Object?>>;
          return Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(221, 245, 246, 1),
              border: Border.all(
                color: const Color.fromRGBO(29, 53, 87, 1),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: MultiSelectDialogField(
                searchable: true,
                listType: MultiSelectListType.CHIP,
                dialogHeight: 160,
                title: Text('Seleccionar'),
                items: _items,
                buttonIcon: const Icon(
                  Icons.home_filled,
                  color: Color.fromRGBO(29, 53, 87, 1),
                ),
                buttonText: const Text(
                  "Colegio",
                  style: TextStyle(
                    color: Color.fromRGBO(29, 53, 87, 1),
                    fontSize: 16,
                  ),
                ),
                onConfirm: (results) {
                  schools = results as List<School>;
                }),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Container(
          height: 1,
          width: 10,
          margin: const EdgeInsets.all(5),
          child: const CircularProgressIndicator(
            strokeWidth: 4,
            valueColor:
                AlwaysStoppedAnimation<Color>(Color.fromRGBO(29, 53, 87, 1)),
          ),
        );
      },
    );
  }
}
