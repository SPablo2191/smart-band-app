import 'package:flutter/material.dart';

class DetailTestPage extends StatefulWidget {
  const DetailTestPage({ super.key});

  @override
  State<DetailTestPage> createState() => _DetailTestPageState();
}

class _DetailTestPageState extends State<DetailTestPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int? id = args['id'];
    return Text('${id}');
  }
}
