import 'package:flutter/material.dart';
import 'package:smartband/src/core/consts/colors.dart';
import 'package:smartband/src/models/exercise_model.dart';
import 'package:smartband/src/providers/exercise_provider.dart';

class ExerciseDropdown extends StatefulWidget {
  final String accessToken;
  final Function(Exercise?) onExerciseSelected;

  const ExerciseDropdown({
    required this.accessToken,
    required this.onExerciseSelected,
  });

  @override
  _ExerciseDropdownState createState() => _ExerciseDropdownState();
}

class _ExerciseDropdownState extends State<ExerciseDropdown> {
  final ExerciseProvider exerciseProvider = ExerciseProvider();
  List<Exercise> exercises = [];
  Exercise? selectedExercise;

  @override
  void initState() {
    super.initState();
    loadExercises();
  }

  void loadExercises() async {
    List<Exercise> fetchedExercises =
        await exerciseProvider.getExercises(widget.accessToken);

    setState(() {
      exercises = fetchedExercises;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colorLight,
          border: Border.all(
            color: colorPrimary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: DropdownButton<Exercise>(
          value: selectedExercise,
          onChanged: (Exercise? newValue) {
            setState(() {
              selectedExercise = newValue;
            });

            widget.onExerciseSelected(newValue);
          },
          hint: const Text(
            'Seleccionar un ejercicio',
            style: TextStyle(color: colorPrimary),
          ),
          dropdownColor: colorSecondary,
          icon: const Icon(Icons.fitness_center_outlined),
          items: exercises.map<DropdownMenuItem<Exercise>>((Exercise value) {
            return DropdownMenuItem<Exercise>(
              value: value,
              child: Text(
                value.description ?? '',
                style: const TextStyle(color: colorPrimary),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
