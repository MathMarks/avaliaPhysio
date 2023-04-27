import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraphMRC extends StatefulWidget {
  final Stream avaliacoes;
  const GraphMRC({Key? key, required this.avaliacoes}) : super(key: key);

  @override
  State<GraphMRC> createState() => _GraphMRCState();
}

class _GraphMRCState extends State<GraphMRC> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
