class ClassVeiculo {
  final int? id; // null para novo cadastro
  final String nome;
  final double litrosTanque;

  final double gasolinaCidade;
  final double gasolinaEstrada;
  final double etanolCidade;
  final double etanolEstrada;

  bool favorita;

  ClassVeiculo({
    this.id,
    required this.nome,
    required this.litrosTanque,
    required this.gasolinaCidade,
    required this.gasolinaEstrada,
    required this.etanolCidade,
    required this.etanolEstrada,
    this.favorita = false,
  });

  /// Para salvar no banco / API
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'litrosTanque': litrosTanque,
      'gasolinaCidade': gasolinaCidade,
      'gasolinaEstrada': gasolinaEstrada,
      'etanolCidade': etanolCidade,
      'etanolEstrada': etanolEstrada,
      'favorita': favorita ? 1 : 0,
    };
  }

  /// Para ler do banco / API
  factory ClassVeiculo.fromMap(Map<String, dynamic> map) {
    return ClassVeiculo(
      id: map['id'],
      nome: map['nome'],
      litrosTanque: map['litrosTanque'],
      gasolinaCidade: map['gasolinaCidade'],
      gasolinaEstrada: map['gasolinaEstrada'],
      etanolCidade: map['etanolCidade'],
      etanolEstrada: map['etanolEstrada'],
      favorita: map['favorita'] == 1,
    );
  }

  /// Útil para editar sem mutar o original
  ClassVeiculo copyWith({
    int? id,
    String? nome,
    double? litrosTanque,
    double? gasolinaCidade,
    double? gasolinaEstrada,
    double? etanolCidade,
    double? etanolEstrada,
    bool? favorita,
  }) {
    return ClassVeiculo(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      litrosTanque: litrosTanque ?? this.litrosTanque,
      gasolinaCidade: gasolinaCidade ?? this.gasolinaCidade,
      gasolinaEstrada: gasolinaEstrada ?? this.gasolinaEstrada,
      etanolCidade: etanolCidade ?? this.etanolCidade,
      etanolEstrada: etanolEstrada ?? this.etanolEstrada,
      favorita: favorita ?? this.favorita,
    );
  }
}
