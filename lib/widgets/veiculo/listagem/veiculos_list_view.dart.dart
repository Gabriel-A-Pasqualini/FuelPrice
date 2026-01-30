import 'package:flutter/material.dart';
import 'package:fuelprice/data/classes/ClassVeiculo.dart';
import 'package:fuelprice/helper/DataBaseHelper.dart';
import 'package:fuelprice/helper/colors_helper.dart';
import 'package:fuelprice/widgets/index/view/widgets/header_widget.dart';

class VeiculosListView extends StatefulWidget {
  const VeiculosListView({super.key});

  @override
  State<VeiculosListView> createState() => _VeiculosListViewState();
}

class _VeiculosListViewState extends State<VeiculosListView> {
  List<ClassVeiculo> veiculos = [];
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarVeiculos();
  }

  Future<void> _carregarVeiculos() async {
    final lista = await DatabaseHelper.instance.getVeiculos();
    if (!mounted) return;

    setState(() {
      veiculos = lista;
      carregando = false;
    });
  }

  Future<void> _definirFavorito(ClassVeiculo veiculo) async {
    await DatabaseHelper.instance.setFavorito(veiculo.id!);
    await _carregarVeiculos();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${veiculo.nome} definido como favorito'),
      ),
    );
  }

  Future<void> _excluirVeiculo(ClassVeiculo veiculo) async {
    await DatabaseHelper.instance.deleteVeiculo(veiculo.id!);
    await _carregarVeiculos();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${veiculo.nome} removido'),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            /// 🔙 BOTÃO VOLTAR
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),

            /// 🧾 HEADER
            const HeaderWidget(
              titulo: "Meus veículos",
            ),

            Expanded(
              child: _buildConteudo(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConteudo() {
    if (carregando) {
      return const Center(child: CircularProgressIndicator());
    }

    if (veiculos.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum veículo cadastrado',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: veiculos.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final veiculo = veiculos[index];
        return _itemVeiculo(veiculo);
      },
    );
  }

  Widget _itemVeiculo(ClassVeiculo veiculo) {
    return Dismissible(
      key: ValueKey(veiculo.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Excluir veículo'),
            content: Text(
              'Deseja realmente excluir "${veiculo.nome}"?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Excluir'),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) => _excluirVeiculo(veiculo),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          title: Text(
            veiculo.nome,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tanque: ${veiculo.litrosTanque} L'),
                Text('Gasolina (cidade): ${veiculo.gasolinaCidade} km/L'),
                Text('Etanol (cidade): ${veiculo.etanolCidade} km/L'),
              ],
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              veiculo.favorita ? Icons.star : Icons.star_border,
              color: veiculo.favorita ? Colors.amber : Colors.grey,
            ),
            onPressed: () => _definirFavorito(veiculo),
          ),
        ),
      ),
    );
  }
}
