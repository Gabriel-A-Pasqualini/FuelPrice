import 'package:flutter/material.dart';
import 'package:fuelprice/data/classes/ClassVeiculo.dart';
import 'package:fuelprice/helper/DataBaseHelper.dart';

class VeiculoController {
  final _db = DatabaseHelper.instance;

  final litrosController = TextEditingController();
  final gasolinaCidadeController = TextEditingController();
  final gasolinaEstradaController = TextEditingController();
  final etanolCidadeController = TextEditingController();
  final etanolEstradaController = TextEditingController();
  final TextEditingController placaController = TextEditingController();
  ClassVeiculo? veiculoPlaca;
  final modeloController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();



  final formKey = GlobalKey<FormState>();

  int? _veiculoId; 

  ClassVeiculo _criarVeiculo() {
    return ClassVeiculo(
      id: _veiculoId,
      nome: nomeController.text.trim().isNotEmpty
          ? nomeController.text.trim()
          : modeloController.text.trim(),

      litrosTanque: double.parse(litrosController.text),
      gasolinaCidade: double.parse(gasolinaCidadeController.text),
      gasolinaEstrada: double.parse(gasolinaEstradaController.text),
      etanolCidade: double.parse(etanolCidadeController.text),
      etanolEstrada: double.parse(etanolEstradaController.text),

      favorita: false,

      placaAntiga: veiculoPlaca?.placaAntiga,
      placaNova: veiculoPlaca?.placaNova,
      marcaModelo: veiculoPlaca?.marcaModelo,
      ano: veiculoPlaca?.ano,
      cor: veiculoPlaca?.cor,
      renavam: veiculoPlaca?.renavam,
      chassi: veiculoPlaca?.chassi,
      codigoMotor: veiculoPlaca?.codigoMotor,
      combustivel: veiculoPlaca?.combustivel,
      tipo: veiculoPlaca?.tipo,
      procedencia: veiculoPlaca?.procedencia,
      carroceria: veiculoPlaca?.carroceria,
      cidade: veiculoPlaca?.cidade,
      estado: veiculoPlaca?.estado,
      cilindradas: veiculoPlaca?.cilindradas,
      potenciaCv: veiculoPlaca?.potenciaCv,
      capacidadePassageiros: veiculoPlaca?.capacidadePassageiros,
    );
  }

  void preencherDadosPorPlaca(Map<String, dynamic> data) {
    veiculoPlaca = ClassVeiculo.fromPlaca(data);
    modeloController.text = veiculoPlaca?.marcaModelo ?? '';
  }

  void _preencherCampos(ClassVeiculo veiculo) {
    _veiculoId = veiculo.id;
    nomeController.text = veiculo.nome;
    litrosController.text = veiculo.litrosTanque.toString();
    gasolinaCidadeController.text = veiculo.gasolinaCidade.toString();
    gasolinaEstradaController.text = veiculo.gasolinaEstrada.toString();
    etanolCidadeController.text = veiculo.etanolCidade.toString();
    etanolEstradaController.text = veiculo.etanolEstrada.toString();
  }

  Future<void> salvar(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    final veiculo = _criarVeiculo();

    if (_veiculoId == null) {
      await _db.insertVeiculo(veiculo);
    } else {
      await _db.updateVeiculo(veiculo);
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Veículo '${veiculo.nome}' salvo com sucesso!"),
        ),
      );
    }

    limpar();
  }


  /// Buscar todos os veículos
  Future<List<ClassVeiculo>> listarVeiculos() async {
    return await _db.getVeiculos();
  }

  /// Carregar veículo para edição
  void editar(ClassVeiculo veiculo) {
    _preencherCampos(veiculo);
  }

  /// Marcar veículo como favorito
  Future<void> definirFavorito(ClassVeiculo veiculo) async {
    if (veiculo.id == null) return;
    await _db.setFavorito(veiculo.id!);
  }

  void limpar() {
    _veiculoId = null;

    veiculoPlaca = null;

    placaController.clear();
    nomeController.clear();
    modeloController.clear();
    litrosController.clear();
    gasolinaCidadeController.clear();
    gasolinaEstradaController.clear();
    etanolCidadeController.clear();
    etanolEstradaController.clear();
  }


  void dispose() {
    placaController.dispose();
    nomeController.dispose();
    litrosController.dispose();
    gasolinaCidadeController.dispose();
    gasolinaEstradaController.dispose();
    etanolCidadeController.dispose();
    etanolEstradaController.dispose();
  }
}
