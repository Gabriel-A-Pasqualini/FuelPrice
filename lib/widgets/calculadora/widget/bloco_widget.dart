import 'package:flutter/material.dart';

class BlocoCard extends StatelessWidget {
  final String titulo;
  final List<Widget> conteudo;
  final IconData icone;
  final Color? cor;

  const BlocoCard({
    super.key,
    required this.titulo,
    required this.conteudo,
    required this.icone,
    this.cor,
  });

  Widget cardTitulo(
    BuildContext context,
    String titulo,
    IconData icone, {
    Color? cor,
  }) {
    final largura = MediaQuery.of(context).size.width;
    final fontSize = largura * 0.045;

    return Row(
      children: [
        Icon(icone, color: cor ?? Colors.blue, size: largura * 0.06),
        SizedBox(width: largura * 0.02),
        Text(
          titulo,
          style: TextStyle(
            color: cor ?? Colors.blue,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;

    final padding = largura * 0.035;
    final margem = largura * 0.01;
    final espacamento = largura * 0.012;

    return Card(
      margin: EdgeInsets.symmetric(vertical: margem),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cardTitulo(context, titulo, icone, cor: cor),
            SizedBox(height: espacamento),
            ...conteudo,
          ],
        ),
      ),
    );
  }
}
