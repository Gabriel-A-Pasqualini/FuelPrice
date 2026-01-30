class ClassVeiculo{
  // === Identificação interna ===
  final int? id;
  bool favorita;

  // === Dados básicos ===
  final String nome; // nome amigável definido pelo usuário
  final double litrosTanque;

  // === Consumo ===
  final double gasolinaCidade;
  final double gasolinaEstrada;
  final double etanolCidade;
  final double etanolEstrada;

  // === Dados oficiais do veículo ===
  final String? placaAntiga;
  final String? placaNova;
  final String? marcaModelo;
  final String? nomeProprietario;
  final String? cpfCnpjProprietario;
  final String? renavam;
  final String? chassi;
  final String? codigoMotor;
  final String? ano;
  final String? procedencia;
  final String? tipo;
  final String? combustivel;
  final String? cor;
  final int? cilindradas;
  final int? potenciaCv;
  final int? capacidadePassageiros;
  final String? carroceria;
  final String? cidade;
  final String? estado;

  ClassVeiculo({
    this.id,
    required this.nome,
    required this.litrosTanque,
    required this.gasolinaCidade,
    required this.gasolinaEstrada,
    required this.etanolCidade,
    required this.etanolEstrada,
    this.favorita = false,

    this.placaAntiga,
    this.placaNova,
    this.marcaModelo,
    this.nomeProprietario,
    this.cpfCnpjProprietario,
    this.renavam,
    this.chassi,
    this.codigoMotor,
    this.ano,
    this.procedencia,
    this.tipo,
    this.combustivel,
    this.cor,
    this.cilindradas,
    this.potenciaCv,
    this.capacidadePassageiros,
    this.carroceria,
    this.cidade,
    this.estado,
  });

  // === Persistência ===
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

      'placaAntiga': placaAntiga,
      'placaNova': placaNova,
      'marcaModelo': marcaModelo,
      'nomeProprietario': nomeProprietario,
      'cpfCnpjProprietario': cpfCnpjProprietario,
      'renavam': renavam,
      'chassi': chassi,
      'codigoMotor': codigoMotor,
      'ano': ano,
      'procedencia': procedencia,
      'tipo': tipo,
      'combustivel': combustivel,
      'cor': cor,
      'cilindradas': cilindradas,
      'potenciaCv': potenciaCv,
      'capacidadePassageiros': capacidadePassageiros,
      'carroceria': carroceria,
      'cidade': cidade,
      'estado': estado,
    };
  }

  factory ClassVeiculo.fromMap(Map<String, dynamic> map) {
    return ClassVeiculo(
      id: map['id'],
      nome: map['nome'],
      litrosTanque: (map['litrosTanque'] as num).toDouble(),
      gasolinaCidade: (map['gasolinaCidade'] as num).toDouble(),
      gasolinaEstrada: (map['gasolinaEstrada'] as num).toDouble(),
      etanolCidade: (map['etanolCidade'] as num).toDouble(),
      etanolEstrada: (map['etanolEstrada'] as num).toDouble(),
      favorita: map['favorita'] == 1,

      placaAntiga: map['placaAntiga'],
      placaNova: map['placaNova'],
      marcaModelo: map['marcaModelo'],
      nomeProprietario: map['nomeProprietario'],
      cpfCnpjProprietario: map['cpfCnpjProprietario'],
      renavam: map['renavam'],
      chassi: map['chassi'],
      codigoMotor: map['codigoMotor'],
      ano: map['ano'],
      procedencia: map['procedencia'],
      tipo: map['tipo'],
      combustivel: map['combustivel'],
      cor: map['cor'],
      cilindradas: map['cilindradas'],
      potenciaCv: map['potenciaCv'],
      capacidadePassageiros: map['capacidadePassageiros'],
      carroceria: map['carroceria'],
      cidade: map['cidade'],
      estado: map['estado'],
    );
  }

  ClassVeiculo copyWith({
    int? id,
    String? nome,
    double? litrosTanque,
    double? gasolinaCidade,
    double? gasolinaEstrada,
    double? etanolCidade,
    double? etanolEstrada,
    bool? favorita,

    String? placaAntiga,
    String? placaNova,
    String? marcaModelo,
    String? nomeProprietario,
    String? cpfCnpjProprietario,
    String? renavam,
    String? chassi,
    String? codigoMotor,
    String? ano,
    String? procedencia,
    String? tipo,
    String? combustivel,
    String? cor,
    int? cilindradas,
    int? potenciaCv,
    int? capacidadePassageiros,
    String? carroceria,
    String? cidade,
    String? estado,
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

      placaAntiga: placaAntiga ?? this.placaAntiga,
      placaNova: placaNova ?? this.placaNova,
      marcaModelo: marcaModelo ?? this.marcaModelo,
      nomeProprietario: nomeProprietario ?? this.nomeProprietario,
      cpfCnpjProprietario: cpfCnpjProprietario ?? this.cpfCnpjProprietario,
      renavam: renavam ?? this.renavam,
      chassi: chassi ?? this.chassi,
      codigoMotor: codigoMotor ?? this.codigoMotor,
      ano: ano ?? this.ano,
      procedencia: procedencia ?? this.procedencia,
      tipo: tipo ?? this.tipo,
      combustivel: combustivel ?? this.combustivel,
      cor: cor ?? this.cor,
      cilindradas: cilindradas ?? this.cilindradas,
      potenciaCv: potenciaCv ?? this.potenciaCv,
      capacidadePassageiros:
          capacidadePassageiros ?? this.capacidadePassageiros,
      carroceria: carroceria ?? this.carroceria,
      cidade: cidade ?? this.cidade,
      estado: estado ?? this.estado,
    );
  }

  factory ClassVeiculo.fromPlaca(Map<String, dynamic> data) {
    return ClassVeiculo(
      nome: data['Marcamodelo'] ?? '',
      litrosTanque: 0,
      gasolinaCidade: 0,
      gasolinaEstrada: 0,
      etanolCidade: 0,
      etanolEstrada: 0,

      placaAntiga: data['PlacaAntiga'],
      placaNova: data['PlacaNova'],
      marcaModelo: data['Marcamodelo'],
      ano: data['Ano'],
      cor: data['Cor'],
    );
  }

}
