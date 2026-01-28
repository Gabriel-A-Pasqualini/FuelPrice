import 'package:flutter/material.dart';
import 'package:fuelprice/helper/DataBaseHelper.dart';

class CalculadoraController {
  final DatabaseHelper db = DatabaseHelper.instance;

  Map<String, dynamic>? resultado;
  bool calculado = false;

  Future<void> calcular({
    required String etanolText,
    required String gasolinaText,
    required String valorText,
    required VoidCallback onUpdate,
    required BuildContext context,
  }) async {
    final precoEtanol =
        double.tryParse(etanolText.replaceAll(',', '.')) ?? 0;
    final precoGasolina =
        double.tryParse(gasolinaText.replaceAll(',', '.')) ?? 0;
    final valorAbastecer =
        double.tryParse(valorText.replaceAll(',', '.')) ?? 0;

    if (precoEtanol <= 0 || precoGasolina <= 0 || valorAbastecer <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ Preencha todos os campos corretamente.")),
      );
      return;
    }

    final veiculo = await db.getVeiculoFavorito();

    if (veiculo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ Nenhum veículo cadastrado.")),
      );
      return;
    }

    final consumoEtanolCidade = veiculo.etanolCidade;
    final consumoEtanolEstrada = veiculo.etanolEstrada;
    final consumoGasolinaCidade = veiculo.gasolinaCidade;
    final consumoGasolinaEstrada = veiculo.gasolinaEstrada;
    final tanqueLitros = veiculo.litrosTanque;

    await db.salvarPrecosCombustivel(
      etanol: precoEtanol,
      gasolina: precoGasolina,
    );

    final relacao = precoEtanol / precoGasolina;

    final kmEtanolCidade = (valorAbastecer / precoEtanol) * consumoEtanolCidade;
    final kmEtanolEstrada = (valorAbastecer / precoEtanol) * consumoEtanolEstrada;
    final kmGasolinaCidade = (valorAbastecer / precoGasolina) * consumoGasolinaCidade;
    final kmGasolinaEstrada = (valorAbastecer / precoGasolina) * consumoGasolinaEstrada;

    final custoKmEtanolCidade = precoEtanol / consumoEtanolCidade;
    final custoKmEtanolEstrada = precoEtanol / consumoEtanolEstrada;
    final custoKmGasolinaCidade = precoGasolina / consumoGasolinaCidade;
    final custoKmGasolinaEstrada = precoGasolina / consumoGasolinaEstrada;

    final tanqueKmEtanolCidade = tanqueLitros * consumoEtanolCidade;
    final tanqueKmEtanolEstrada = tanqueLitros * consumoEtanolEstrada;
    final tanqueKmGasolinaCidade = tanqueLitros * consumoGasolinaCidade;
    final tanqueKmGasolinaEstrada = tanqueLitros * consumoGasolinaEstrada;

    final economiaCidadeKm = (kmGasolinaCidade - kmEtanolCidade).abs();
    final economiaEstradaKm = (kmGasolinaEstrada - kmEtanolEstrada).abs();

    final economiaCidadeReais = economiaCidadeKm *
        (custoKmEtanolCidade < custoKmGasolinaCidade
            ? custoKmEtanolCidade
            : custoKmGasolinaCidade);
    final economiaEstradaReais = economiaEstradaKm *
        (custoKmEtanolEstrada < custoKmGasolinaEstrada
            ? custoKmEtanolEstrada
            : custoKmGasolinaEstrada);

    final melhorCombustivel = relacao < 0.7 ? "ETANOL" : "GASOLINA";

    resultado = {
      "relacao": relacao,
      "melhor": melhorCombustivel,
      "valor": valorAbastecer,
      "km": {
        "etanolCidade": kmEtanolCidade,
        "etanolEstrada": kmEtanolEstrada,
        "gasolinaCidade": kmGasolinaCidade,
        "gasolinaEstrada": kmGasolinaEstrada,
      },
      "custoKm": {
        "etanolCidade": custoKmEtanolCidade,
        "etanolEstrada": custoKmEtanolEstrada,
        "gasolinaCidade": custoKmGasolinaCidade,
        "gasolinaEstrada": custoKmGasolinaEstrada,
      },
      "tanque": {
        "etanolCidade": tanqueKmEtanolCidade,
        "etanolEstrada": tanqueKmEtanolEstrada,
        "gasolinaCidade": tanqueKmGasolinaCidade,
        "gasolinaEstrada": tanqueKmGasolinaEstrada,
      },
      "economia": {
        "cidadeKm": economiaCidadeKm,
        "estradaKm": economiaEstradaKm,
        "cidadeR": economiaCidadeReais,
        "estradaR": economiaEstradaReais,
      }
    };

    calculado = true;
    onUpdate();
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
