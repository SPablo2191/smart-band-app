
import 'package:flutter/material.dart';
import 'package:smartband/src/core/consts/colors.dart';
import 'package:smartband/src/pages/start_page.dart';
import 'package:smartband/src/widgets/home_button_widget.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../models/school_model.dart';
import '../../providers/school_provider.dart';

class PromotionCreate_page extends StatefulWidget {
  const PromotionCreate_page({super.key});

  @override
  State<PromotionCreate_page> createState() => _PromotionCreate_page();
}

class _PromotionCreate_page extends State<PromotionCreate_page> {
  @override
  List<School> schoolsSelected = [];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Crear promociones',
            style:
                TextStyle(color: Color.fromRGBO(29, 53, 87, 1), fontSize: 30),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pushNamed(context, 'promotion');
          },
        ),
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        children: [
          Container(height: 30),
          _getSchools(),
          Container(height: 30),
          _yearGraduation(),
          Container(height: 30),
          _actualClass(),
          Container(height: 100),
          _buttonCreate('Crear Promocion',const Color.fromRGBO(29, 53, 87, 1),context,''),
          Container(height: 20),
          _buttonCreate('Cancelar',Color.fromARGB(255, 230, 55, 55),context,'promotion'),
        ],
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

  _yearGraduation(){
     return TextField(
      keyboardType: TextInputType.datetime,
      onChanged: (value) => setState(() {
        
      }),
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
              borderSide:
                  const BorderSide(color: Color.fromRGBO(29, 53, 87, 1))),
          hintText: '', //placeholder
          labelText: 'Año de graduacion',
          prefixIcon: const Icon(Icons.calendar_month)),
    );
  }

  _actualClass(){
    return TextField(
      keyboardType: TextInputType.text,
      onChanged: (value) => setState(() {
        
      }),
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
              borderSide:
                  const BorderSide(color: Color.fromRGBO(29, 53, 87, 1))),
          hintText: 'Patitos', //placeholder
          labelText: 'Clase actual',
          prefixIcon: const Icon(Icons.bookmark)),
    );
  }

  _buttonCreate(String label, color, BuildContext context, String route,
      {borderColor = Colors.white, textColor = Colors.white}) {
    return ElevatedButton(
      onPressed: () {
          Navigator.pushNamed(context, route);
        },
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

}