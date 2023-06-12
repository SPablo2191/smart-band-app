import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:smartband/src/models/school_model.dart';
import 'package:smartband/src/providers/auth_provider.dart';
import 'package:smartband/src/providers/school_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../models/teacher_model.dart';
import '../../widgets/appbar_widget.dart';

class RegisterStep2Page extends StatefulWidget {
  const RegisterStep2Page({super.key, this.teacher});
  final Teacher? teacher;
  @override
  State<RegisterStep2Page> createState() => _RegisterStep2PageState();
}

class _RegisterStep2PageState extends State<RegisterStep2Page> {
  List<School> schoolsSelected = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Registrarse'),
      body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
            _getButton(
                'Registrar', const Color.fromRGBO(29, 53, 87, 1), context, '/'),
            Container(
                margin: const EdgeInsets.only(top: 46.0),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Container(
                    margin: const EdgeInsets.only(top: 10),
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
        widget.teacher?.DNI = value;
      }),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        iconColor: const Color.fromRGBO(29, 53, 87, 1),
        labelStyle: const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        floatingLabelStyle:
            const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        hintStyle: const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        fillColor: const Color.fromRGBO(221, 245, 246, 1),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Color.fromRGBO(29, 53, 87, 1))),
        labelText: 'DNI',
        helperText: '9 caracteres maximo',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
    );
  }

  _getName() {
    return TextField(
      onChanged: (value) => setState(() {
        widget.teacher?.name = value;
      }),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        iconColor: const Color.fromRGBO(29, 53, 87, 1),
        labelStyle: const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        floatingLabelStyle:
            const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        hintStyle: const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        fillColor: const Color.fromRGBO(221, 245, 246, 1),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Color.fromRGBO(29, 53, 87, 1))),
        labelText: 'Nombre',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
    );
  }

  _getLastName() {
    return TextField(
      onChanged: (value) => setState(() {
        widget.teacher?.last_name = value;
      }),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        iconColor: const Color.fromRGBO(29, 53, 87, 1),
        labelStyle: const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        floatingLabelStyle:
            const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        hintStyle: const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        fillColor: const Color.fromRGBO(221, 245, 246, 1),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Color.fromRGBO(29, 53, 87, 1))),
        labelText: 'Apellido',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
    );
  }

  _getButton(String label, color, BuildContext context, String route,
      {borderColor = Colors.white, textColor = Colors.white}) {
    return ElevatedButton(
      onPressed: () => _register(),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        minimumSize: const Size(250, 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: borderColor, width: 1.0)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  _getSchools() {
    final SchoolProvider schoolProvider = SchoolProvider();
    return FutureBuilder(
      future: schoolProvider.getSchools(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data
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
                title: const Text('Seleccionar'),
                items: items,
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
                  List<School> options = [];
                  for (dynamic element in results) {
                    School aux = School(name: element?.name, id: element?.id);
                    options.add(element);
                  }
                  schoolsSelected = options;
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

  _register() {
    widget.teacher?.schools = schoolsSelected;
    if (!widget.teacher?.isValid()) {
      return;
    }
    AuthProvider registerProvider = AuthProvider();
    Teacher aux = widget.teacher ?? Teacher();
    registerProvider.register(aux);
    Fluttertoast.showToast(
        msg: "¡Usuario Registrado con exito!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: const Color.fromRGBO(29, 53, 87, 1),
        textColor: const Color.fromRGBO(221, 245, 246, 1),
        fontSize: 16.0);
    Future.delayed(
        Duration(seconds: 2), () => {Navigator.pushNamed(context, '/')});
  }
}
