import 'package:fuelprice/widgets/calculadora/classes/class_combustivel_info.dart';
import 'package:fuelprice/widgets/calculadora/classes/class_economia_info.dart';

class ResultadoCalculo {
  final double relacao;
  final String melhorCombustivel;
  final double valorAbastecido;

  final CombustivelInfo km;
  final CombustivelInfo custoKm;
  final CombustivelInfo tanque;

  final EconomiaInfo economia;

  const ResultadoCalculo({
    required this.relacao,
    required this.melhorCombustivel,
    required this.valorAbastecido,
    required this.km,
    required this.custoKm,
    required this.tanque,
    required this.economia,
  });
}