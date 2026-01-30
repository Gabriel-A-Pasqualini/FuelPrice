import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';

class VehicleRemoteDatasource {
  Future<Map<String, String?>> fetchVehicleInfo(String plate) async {
    final url = Uri.parse('https://placasbrasil.com/placa/$plate');

    final response = await http.get(
      url,
      headers: {
        'user-agent':
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar dados');
    }

    final document = parser.parse(response.body);
    final Map<String, String?> result = {};

    final cards = document.querySelectorAll('.card-detail');

    for (final card in cards) {
      final label = card.querySelector('strong')?.text;
      final value = card.querySelector('span')?.text;

      if (label == null || value == null) continue;

      final key = _toCamelCase(label.replaceAll(':', ''));
      result[key] = value.contains('Desbloquear') ? null : value.trim();
    }

    return result;
  }

  String _toCamelCase(String text) {
    final words = text
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .split(' ');
    return words.first +
        words.skip(1).map((e) => e[0].toUpperCase() + e.substring(1)).join();
  }
}
