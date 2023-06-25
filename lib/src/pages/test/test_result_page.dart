import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vital/src/core/consts/colors.dart';
import 'package:vital/src/widgets/appbar_widget.dart';
import 'package:vital/src/widgets/bottom_navigation_bar_widget.dart';
import 'package:vital/src/widgets/exercise_dropdown_widget.dart';

import '../../models/exercise_model.dart';
import '../../models/result_model.dart';
import '../../models/student_model.dart';

class TestResultPage extends StatefulWidget {
  const TestResultPage({super.key});

  @override
  State<TestResultPage> createState() => _TestResultPageState();
}

class _TestResultPageState extends State<TestResultPage> {
  final Result _newResult = Result();
  String? _accessToken = '';
  Exercise? selectedExercise;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  onExerciseSelected(Exercise? exercise) {
    setState(() {
      selectedExercise = exercise;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Student? student = args['student'];
    final int? promotionId = args != null ? args['promotion_id'] : null;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Registrar Resultado',
        centerTitle: false,
        showBackButton: true,
        path: 'test/detail',
        args: {
          'promotion_id': promotionId,
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Estudiante: ${student!.name} ${student.last_name}',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colorPrimary),
              ),
            ),
            const SizedBox(height: 20),
            _getDeviceName(),
            const SizedBox(height: 10.0),
            _getNumberSteps(),
            const SizedBox(height: 10.0),
            _getCalories(),
            const SizedBox(height: 10.0),
            _getAverageHeartRate(),
            const SizedBox(height: 10.0),
            _getAverageRate(),
            const SizedBox(height: 10.0),
            _getAverageSpeed(),
            const SizedBox(height: 10.0),
            _getAverageCadence(),
            const SizedBox(height: 10.0),
            _getAverageStride(),
            const SizedBox(height: 10.0),
            _getExercises()
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  _getNumberSteps() {
    return TextField(
      onChanged: (value) => setState(() {
        _newResult.number_steps = int.tryParse(value);
      }),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        iconColor: colorPrimary,
        labelStyle: const TextStyle(color: colorPrimary),
        floatingLabelStyle: const TextStyle(color: colorPrimary),
        hintStyle: const TextStyle(color: colorPrimary),
        fillColor: colorLight,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: colorPrimary)),
        labelText: 'Pasos',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // Permite solo dígitos
      ],
      keyboardType: TextInputType.number,
    );
  }

  _getCalories() {
    return TextField(
      onChanged: (value) => setState(() {
        _newResult.calories = value;
      }),
      decoration: InputDecoration(
        filled: true,
        iconColor: colorPrimary,
        labelStyle: const TextStyle(color: colorPrimary),
        floatingLabelStyle: const TextStyle(color: colorPrimary),
        hintStyle: const TextStyle(color: colorPrimary),
        fillColor: colorLight,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: colorPrimary)),
        labelText: 'Calorias',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
    );
  }

  _getAverageHeartRate() {
    return TextField(
      onChanged: (value) => setState(() {
        _newResult.average_heart_rate = double.tryParse(value);
      }),
      decoration: InputDecoration(
        filled: true,
        iconColor: colorPrimary,
        labelStyle: const TextStyle(color: colorPrimary),
        floatingLabelStyle: const TextStyle(color: colorPrimary),
        hintStyle: const TextStyle(color: colorPrimary),
        fillColor: colorLight,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: colorPrimary)),
        labelText: 'Ritmo Cardiaco Promedio',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // Permite solo dígitos
      ],
      keyboardType: TextInputType.number,
    );
  }

  _getAverageRate() {
    return TextField(
      onChanged: (value) => setState(() {
        _newResult.calories = value;
      }),
      decoration: InputDecoration(
        filled: true,
        iconColor: colorPrimary,
        labelStyle: const TextStyle(color: colorPrimary),
        floatingLabelStyle: const TextStyle(color: colorPrimary),
        hintStyle: const TextStyle(color: colorPrimary),
        fillColor: colorLight,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: colorPrimary)),
        labelText: 'Ritmo Medio',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
    );
  }

  _getAverageSpeed() {
    return TextField(
      onChanged: (value) => setState(() {
        _newResult.average_speed = double.tryParse(value);
      }),
      decoration: InputDecoration(
        filled: true,
        iconColor: colorPrimary,
        labelStyle: const TextStyle(color: colorPrimary),
        floatingLabelStyle: const TextStyle(color: colorPrimary),
        hintStyle: const TextStyle(color: colorPrimary),
        fillColor: colorLight,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: colorPrimary)),
        labelText: 'Velocidad Media (km/h)',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // Permite solo dígitos
      ],
      keyboardType: TextInputType.number,
    );
  }

  _getAverageCadence() {
    return TextField(
      onChanged: (value) => setState(() {
        _newResult.average_cadene = double.tryParse(value);
      }),
      decoration: InputDecoration(
        filled: true,
        iconColor: colorPrimary,
        labelStyle: const TextStyle(color: colorPrimary),
        floatingLabelStyle: const TextStyle(color: colorPrimary),
        hintStyle: const TextStyle(color: colorPrimary),
        fillColor: colorLight,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: colorPrimary)),
        labelText: 'Cadencia media',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // Permite solo dígitos
      ],
      keyboardType: TextInputType.number,
    );
  }

  _getAverageStride() {
    return TextField(
      onChanged: (value) => setState(() {
        _newResult.average_stride = double.tryParse(value);
      }),
      decoration: InputDecoration(
        filled: true,
        iconColor: colorPrimary,
        labelStyle: const TextStyle(color: colorPrimary),
        floatingLabelStyle: const TextStyle(color: colorPrimary),
        hintStyle: const TextStyle(color: colorPrimary),
        fillColor: colorLight,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: colorPrimary)),
        labelText: 'Zancada Media (cm)',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // Permite solo dígitos
      ],
      keyboardType: TextInputType.number,
    );
  }

  _getDeviceName() {
    return TextField(
      onChanged: (value) => setState(() {
        _newResult.device_name = value;
      }),
      decoration: InputDecoration(
        filled: true,
        iconColor: colorPrimary,
        labelStyle: const TextStyle(color: colorPrimary),
        floatingLabelStyle: const TextStyle(color: colorPrimary),
        hintStyle: const TextStyle(color: colorPrimary),
        fillColor: colorLight,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: colorPrimary)),
        labelText: 'Nombre del dispositivo',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
    );
  }

  Future<String?> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('accessToken');
    return _accessToken;
  }

  _getExercises() {
    return FutureBuilder(
      future: _loadData().then((value) => ExerciseDropdown(
          accessToken: _accessToken!, onExerciseSelected: onExerciseSelected)),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? snapshot.data
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
