class ClassConfiguracao {
  final double precoEtanol;
  final double precoGasolina;

  ClassConfiguracao({
    required this.precoEtanol,
    required this.precoGasolina,
  });

  factory ClassConfiguracao.fromMap(Map<String, dynamic> map) {
    return ClassConfiguracao(
      precoEtanol: map['precoEtanol'],
      precoGasolina: map['precoGasolina'],
    );
  }
}
