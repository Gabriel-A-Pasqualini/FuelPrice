class ClassVeiculo {
  final int numeroVeiculo;
  final String nomeVeiculo;
  bool favorita; // não mais final

  ClassVeiculo(this.numeroVeiculo, this.nomeVeiculo, this.favorita);

  Map<String, dynamic> toMap() => {
        'numeroVeiculo': numeroVeiculo,
        'nomeVeiculo': nomeVeiculo,
        'favorita': favorita ? 1 : 0,
      };

  factory ClassVeiculo.fromMap(Map<String, dynamic> map) => ClassVeiculo(
        map['numeroVeiculo'],
        map['nomeVeiculo'],
        map['favorita'] == 1,
      );
}
