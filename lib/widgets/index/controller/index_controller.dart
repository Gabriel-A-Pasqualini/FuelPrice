import 'package:flutter/material.dart';
import 'package:fuelprice/helper/DataBaseHelper.dart';

class IndexController extends ChangeNotifier {
  final DatabaseHelper db = DatabaseHelper.instance;


  String nomeUsuario = '';
  String modeloCarro = '';
  double capacidadeTanque = 0;
  double consumoMedio = 0;
  double litrosAtuais = 0;
  double kmPorDia = 0;
  double precoEtanol = 0;
  double precoGasolina = 0;

  bool carregando = true;

  Future<void> carregarDados() async {
    carregando = true;
    notifyListeners();

    final veiculo = await db.getVeiculoFavorito();

    if (veiculo == null) {
      carregando = false;
      notifyListeners();
      return;
    }

    nomeUsuario = "Gabriel";
    modeloCarro = veiculo.nome;
    capacidadeTanque = veiculo.litrosTanque;

    consumoMedio =
        (veiculo.gasolinaCidade + veiculo.gasolinaEstrada) / 2;

    kmPorDia = 35;
    carregando = false;

    notifyListeners();
  }

  void tanqueCheio() {
    litrosAtuais = capacidadeTanque;
    notifyListeners();
  }

  Future<void> carregarPrecos() async {
    final precos = await db.getPrecosCombustivel();

    precoEtanol = precos?.precoEtanol ?? 0;
    precoGasolina = precos?.precoGasolina ?? 0;

    notifyListeners();
  }  

  void atualizarLitrosAtuais(double valor) {
    if (valor < 0) valor = 0;
    if (valor > capacidadeTanque) valor = capacidadeTanque;

    litrosAtuais = valor;
    notifyListeners();
  }

  double get nivelTanqueAtual {
    if (capacidadeTanque == 0) return 0;
    return litrosAtuais / capacidadeTanque;
  }

  int get porcentagemTanque =>
      (nivelTanqueAtual * 100).round();

  double get autonomiaKm =>
      litrosAtuais * consumoMedio;

  int get diasRestantes {
    if (kmPorDia == 0) return 0;
    return (autonomiaKm / kmPorDia).floor();
  }
  double get litrosFaltantes {
    final faltante = capacidadeTanque - litrosAtuais;
    return faltante < 0 ? 0 : faltante;
  }
  double get estimativaAbastecimento =>
      litrosFaltantes * precoEtanol;
}
