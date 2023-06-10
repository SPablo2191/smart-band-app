import 'package:flutter/material.dart';
import 'package:smartband/src/core/consts/colors.dart';
import 'package:smartband/src/models/promotion_model.dart';
import 'package:smartband/src/pages/start_page.dart';
import 'package:smartband/src/widgets/home_button_widget.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../models/school_model.dart';
import '../providers/school_provider.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({super.key});

  @override
  State<PromotionPage> createState() => _PromotionPage();
}

class _PromotionPage extends State<PromotionPage> {
  @override
  List<School> schoolsSelected = [];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Ver promociones',
            style:
                TextStyle(color: Color.fromRGBO(29, 53, 87, 1), fontSize: 30),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pushNamed(context, 'home');
          },
        ),
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        children: [
          Container(height: 30),
          _promotion(),
          Container(height: 25),
          _getSchools(),
          Container(
            height: 20,
          ),
          Text(
            'Promociones',
            style: TextStyle(color: colorPrimary, fontSize: 20),
          ),
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

  _promotion() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(221, 245, 246, 1),
        border: Border.all(
          color: const Color.fromRGBO(29, 53, 87, 1),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: const Color.fromRGBO(221, 245, 246, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: Color.fromRGBO(29, 53, 87, 1),
              width: 0.5,
            ),
          ),
          minimumSize: const Size(double.infinity, 55),
        ),
        onPressed: () {
          // Aquí puedes agregar la funcionalidad del botón si es necesario
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 8),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.home_filled,
                  color: Color.fromRGBO(29, 53, 87, 1),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Crear promocion",
                  style: TextStyle(
                    color: Color.fromRGBO(29, 53, 87, 1),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
