import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tux_data_f/models/distribution.dart'; // Importiamo il nostro modello

class DistributionService {
  // Usiamo lo stesso IP speciale di prima per l'emulatore
  static const String _baseUrl = 'http://10.0.2.2:8080/distributions';

  Future<List<Distribution>> getDistributions() async {
    final url = Uri.parse(_baseUrl);

    try {
      // NOTA: Per ora questa chiamata non è autenticata.
      // In un'app reale, qui dovremmo aggiungere l'header con il token JWT.
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Se la chiamata ha successo, il backend ci dà una lista di oggetti JSON.
        // La decodifichiamo in una List<dynamic>.
        final List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

        // Usiamo il metodo .map() per trasformare ogni oggetto JSON in un oggetto Distribution
        // e poi .toList() per ottenere la nostra lista finale.
        final List<Distribution> distributions = body
            .map((dynamic item) =>
                Distribution.fromJson(item as Map<String, dynamic>))
            .toList();

        return distributions;
      } else {
        // Se il server risponde con un errore, lo segnaliamo.
        throw Exception(
            'Failed to load distributions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Se c'è un errore di rete o di parsing, lo segnaliamo.
      throw Exception('An error occurred while fetching distributions: $e');
    }
  }
}
