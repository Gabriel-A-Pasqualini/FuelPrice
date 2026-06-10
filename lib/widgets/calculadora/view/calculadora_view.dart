import 'package:flutter/material.dart';
import 'package:fuelprice/widgets/calculadora/classes/ClassAbastecimentoForm.dart';
import 'package:fuelprice/widgets/calculadora/classes/ClassCalculadoraActions.dart';
import 'package:fuelprice/widgets/calculadora/classes/ClassResultadoSection.dart';
import 'package:fuelprice/helper/colors_helper.dart';
import 'package:fuelprice/widgets/calculadora/controller/calculadora_controller.dart';
import 'package:fuelprice/widgets/index/view/widgets/header_widget.dart';

  class CalculadoraCombustivelWidget extends StatefulWidget {
    const CalculadoraCombustivelWidget({super.key});

    @override
    State<CalculadoraCombustivelWidget> createState() =>
        CalculadoraCombustivelWidgetState();
  }

  class CalculadoraCombustivelWidgetState
      extends State<CalculadoraCombustivelWidget> {

    late final CalculadoraController controller;

    final etanolController = TextEditingController();
    final gasolinaController = TextEditingController();
    final valorController = TextEditingController();

    final focusEtanol = FocusNode();

    @override
    void initState() {
      super.initState();

      controller = CalculadoraController();

      _carregarPrecos();
    }

    Future<void> _carregarPrecos() async {
      final config = await controller.db.getPrecosCombustivel();

      if (config != null) {
        etanolController.text =
            config.precoEtanol.toStringAsFixed(2).replaceAll('.', ',');

        gasolinaController.text =
            config.precoGasolina.toStringAsFixed(2).replaceAll('.', ',');
      }

      if (mounted) {
        setState(() {});
      }
    }

    void _atualizarTela() {
      if (mounted) {
        setState(() {});
      }
    }

    Future<void> atualizarTela() async {
      await _carregarPrecos();
    }    

    @override
    void dispose() {
      etanolController.dispose();
      gasolinaController.dispose();
      valorController.dispose();
      focusEtanol.dispose();

      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: HeaderWidget(
                  titulo: "Calculadora de\nAbastecimento",
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [

                      AbastecimentoForm(
                        etanolController: etanolController,
                        gasolinaController: gasolinaController,
                        valorController: valorController,
                        focusEtanol: focusEtanol,
                      ),

                      const SizedBox(height: 20),

                      CalculadoraActions(
                        controller: controller,
                        etanolController: etanolController,
                        gasolinaController: gasolinaController,
                        valorController: valorController,
                        onUpdate: _atualizarTela,
                      ),

                      const SizedBox(height: 20),

                      ResultadoSection(
                        calculado: controller.calculado,
                        resultado: controller.resultado,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

