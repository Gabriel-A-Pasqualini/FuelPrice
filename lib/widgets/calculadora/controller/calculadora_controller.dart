import 'package:flutter/material.dart';
import 'package:fuelprice/widgets/calculadora/classes/class_combustivel_info.dart';
import 'package:fuelprice/widgets/calculadora/classes/class_economia_info.dart';
import 'package:fuelprice/widgets/calculadora/classes/class_resultado_calculo.dart';
import 'package:fuelprice/data/classes/class_veiculo.dart';
import 'package:fuelprice/helper/data_base_helper.dart';

class CalculadoraController {
  final DatabaseHelper db = DatabaseHelper.instance;

  ResultadoCalculo? resultado;
  bool calculado = false;

  Future<void> calcular({
    required String etanolText,
    required String gasolinaText,
    required String valorText,
    required VoidCallback onUpdate,
    required BuildContext context,
  }) async {
    final precoEtanol = _parseValor(etanolText);
    final precoGasolina = _parseValor(gasolinaText);
    final valorAbastecer = _parseValor(valorText);

    if (_camposInvalidos(
      precoEtanol,
      precoGasolina,
      valorAbastecer,
    )) {
      _mostrarMensagem(
        context,
        "⚠️ Preencha todos os campos corretamente.",
      );
      return;
    }

    final veiculo = await db.getVeiculoFavorito();

    if (veiculo == null) {
      _mostrarMensagem(
        context,
        "⚠️ Nenhum veículo cadastrado.",
      );
      return;
    }

    await _salvarUltimosPrecos(
      precoEtanol,
      precoGasolina,
    );

    resultado = _gerarResultado(
      veiculo,
      precoEtanol,
      precoGasolina,
      valorAbastecer,
    );

    calculado = true;
    onUpdate();
  }

  Future<void> _salvarUltimosPrecos(
    double etanol,
    double gasolina,
  ) async {
    await db.salvarPrecosCombustivel(
      etanol: etanol,
      gasolina: gasolina,
    );
  }

  ResultadoCalculo _gerarResultado(
    ClassVeiculo veiculo,
    double precoEtanol,
    double precoGasolina,
    double valorAbastecer,
  ) {
    final relacao = precoEtanol / precoGasolina;

    final kmEtanolCidade = _calcularAutonomia(
      valorAbastecer,
      precoEtanol,
      veiculo.etanolCidade,
    );

    final kmEtanolEstrada = _calcularAutonomia(
      valorAbastecer,
      precoEtanol,
      veiculo.etanolEstrada,
    );

    final kmGasolinaCidade = _calcularAutonomia(
      valorAbastecer,
      precoGasolina,
      veiculo.gasolinaCidade,
    );

    final kmGasolinaEstrada = _calcularAutonomia(
      valorAbastecer,
      precoGasolina,
      veiculo.gasolinaEstrada,
    );

    final custoKmEtanolCidade = _calcularCustoKm(
      precoEtanol,
      veiculo.etanolCidade,
    );

    final custoKmEtanolEstrada = _calcularCustoKm(
      precoEtanol,
      veiculo.etanolEstrada,
    );

    final custoKmGasolinaCidade = _calcularCustoKm(
      precoGasolina,
      veiculo.gasolinaCidade,
    );

    final custoKmGasolinaEstrada = _calcularCustoKm(
      precoGasolina,
      veiculo.gasolinaEstrada,
    );

    final economiaCidadeKm =
        (kmGasolinaCidade - kmEtanolCidade).abs();

    final economiaEstradaKm =
        (kmGasolinaEstrada - kmEtanolEstrada).abs();

    final economiaCidadeReais =
        economiaCidadeKm *
        _menorValor(
          custoKmEtanolCidade,
          custoKmGasolinaCidade,
        );

    final economiaEstradaReais =
        economiaEstradaKm *
        _menorValor(
          custoKmEtanolEstrada,
          custoKmGasolinaEstrada,
        );

    return ResultadoCalculo(
      relacao: relacao,
      melhorCombustivel: _obterMelhorCombustivel(relacao),
      valorAbastecido: valorAbastecer,

      km: CombustivelInfo(
        etanolCidade: kmEtanolCidade,
        etanolEstrada: kmEtanolEstrada,
        gasolinaCidade: kmGasolinaCidade,
        gasolinaEstrada: kmGasolinaEstrada,
      ),

      custoKm: CombustivelInfo(
        etanolCidade: custoKmEtanolCidade,
        etanolEstrada: custoKmEtanolEstrada,
        gasolinaCidade: custoKmGasolinaCidade,
        gasolinaEstrada: custoKmGasolinaEstrada,
      ),

      tanque: CombustivelInfo(
        etanolCidade:
            veiculo.litrosTanque * veiculo.etanolCidade,
        etanolEstrada:
            veiculo.litrosTanque * veiculo.etanolEstrada,
        gasolinaCidade:
            veiculo.litrosTanque * veiculo.gasolinaCidade,
        gasolinaEstrada:
            veiculo.litrosTanque * veiculo.gasolinaEstrada,
      ),

      economia: EconomiaInfo(
        cidadeKm: economiaCidadeKm,
        estradaKm: economiaEstradaKm,
        cidadeReais: economiaCidadeReais,
        estradaReais: economiaEstradaReais,
      ),
    );
  }
    
  double _parseValor(String valor) {
    return double.tryParse(
          valor.replaceAll(',', '.'),
        ) ??
        0;
  }

  bool _camposInvalidos(
    double etanol,
    double gasolina,
    double valor,
  ) {
    return etanol <= 0 ||
        gasolina <= 0 ||
        valor <= 0;
  }

  double _calcularAutonomia(
    double valorAbastecido,
    double precoCombustivel,
    double consumo,
  ) {
    return (valorAbastecido / precoCombustivel) * consumo;
  }

  double _calcularCustoKm(
    double precoCombustivel,
    double consumo,
  ) {
    return precoCombustivel / consumo;
  }

  double _menorValor(
    double valor1,
    double valor2,
  ) {
    return valor1 < valor2 ? valor1 : valor2;
  }

  String _obterMelhorCombustivel(double relacao) {
    return relacao < 0.70
        ? "ETANOL"
        : "GASOLINA";
  }

  void _mostrarMensagem(
    BuildContext context,
    String mensagem,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  void limpar({
    required TextEditingController etanolController,
    required TextEditingController gasolinaController,
    required TextEditingController valorController,
    required VoidCallback onUpdate,
  }) {
    etanolController.clear();
    gasolinaController.clear();
    valorController.clear();

    resultado = null;
    calculado = false;

    onUpdate();
  }
}