class ClassConfiguracao {
  final double kmRodadoDia;
  final double litrosAtuais;
  final double precoEtanol;
  final double precoGasolina;

  ClassConfiguracao({
    required this.kmRodadoDia,
    required this.litrosAtuais,
    required this.precoEtanol,
    required this.precoGasolina,
  });

  factory ClassConfiguracao.fromMap(Map<String, dynamic> map) {
    return ClassConfiguracao(
      kmRodadoDia: map['kmRodadoDia'] ?? 0.0,
      litrosAtuais: map['litrosAtuais'] ?? 0.0,
      precoEtanol: map['precoEtanol'] ?? 0.0,
      precoGasolina: map['precoGasolina'] ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': 1,
      'kmRodadoDia': kmRodadoDia,
      'litrosAtuais': litrosAtuais,
      'precoEtanol': precoEtanol,
      'precoGasolina': precoGasolina,
    };
  }
}
