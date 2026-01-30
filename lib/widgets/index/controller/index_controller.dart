import 'package:flutter/material.dart';
import 'package:fuelprice/helper/DataBaseHelper.dart';
class IndexController extends ChangeNotifier {
  final DatabaseHelper db = DatabaseHelper.instance;

  double kmRodadoDia = 0;
  double litrosAtuais = 0;
  double precoEtanol = 0;
  double precoGasolina = 0;

  String nomeUsuario = '';
  String modeloCarro = '';
  double capacidadeTanque = 0;
  double consumoMedio = 0;
  double kmPorDia = 0;

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

    carregando = false;

    notifyListeners();
  }

  void tanqueCheio() {
    litrosAtuais = capacidadeTanque;
    notifyListeners();
  }

  Future<void> carregarConfiguracoes() async {
    final config = await db.getPrecosCombustivel();
    if (config == null) return;

    kmRodadoDia = config.kmRodadoDia;
    litrosAtuais = config.litrosAtuais;
    precoEtanol = config.precoEtanol;
    precoGasolina = config.precoGasolina;

    notifyListeners();
  }

  Future<void> salvarConfiguracoes({
    required double kmRodadoDia,
    required double litrosAtuais,
    required double precoEtanol,
    required double precoGasolina,
  }) async {

    await db.salvarConfiguracoes(
      kmRodadoDia: kmRodadoDia,
      litrosAtuais: litrosAtuais,
      precoEtanol: precoEtanol,
      precoGasolina: precoGasolina,
    );
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
    if (kmRodadoDia == 0) return 0;
    return (autonomiaKm / kmRodadoDia).floor();
  }
  double get litrosFaltantes {
    final faltante = capacidadeTanque - litrosAtuais;
    return faltante < 0 ? 0 : faltante;
  }
  double get estimativaAbastecimento =>
      litrosFaltantes * precoEtanol;
}
