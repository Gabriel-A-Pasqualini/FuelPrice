import 'package:fuelprice/widgets/calculadora/classes/ClassCombustivelInfo.dart';
import 'package:fuelprice/widgets/calculadora/classes/ClassEconomiaInfo.dart';

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