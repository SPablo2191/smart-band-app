// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:vital/src/core/consts/colors.dart';

import '../models/school_model.dart';
import '../models/promotion_model.dart';
import '../providers/school_provider.dart';
import '../providers/promotion_provider.dart';

class PromotionDropdown extends StatefulWidget {
  final String accessToken;
  final int schoolId;
  final Function(Promotion?) onPromotionSelected;

  const PromotionDropdown({
    required this.accessToken,
    required this.schoolId,
    required this.onPromotionSelected,
  });

  @override
  _PromotionDropdownState createState() => _PromotionDropdownState();
}

class _PromotionDropdownState extends State<PromotionDropdown> {
  final PromotionProvider promotionProvider = PromotionProvider();
  List<Promotion> promotions = [];
  Promotion? selectedPromotion;

  @override
  void initState() {
    super.initState();
    loadPromotions();
  }

  void loadPromotions() async {
    List<Promotion> fetchedPromotions = await promotionProvider.getPromotions(
        widget.schoolId, widget.accessToken);

    setState(() {
      promotions = fetchedPromotions;
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
        child: DropdownButton<Promotion>(
          value: selectedPromotion,
          onChanged: (Promotion? newValue) {
            setState(() {
              selectedPromotion = newValue;
            });

            widget.onPromotionSelected(newValue);
          },
          hint: const Text(
            'Seleccionar una promoción',
            style: TextStyle(color: colorPrimary),
          ),
          dropdownColor: colorSecondary,
          icon: const Icon(Icons.school_outlined),
          items: promotions.map<DropdownMenuItem<Promotion>>((Promotion value) {
            return DropdownMenuItem<Promotion>(
              value: value,
              child: Text(
                value.classroom?.name ?? '',
                style: const TextStyle(color: colorPrimary),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
