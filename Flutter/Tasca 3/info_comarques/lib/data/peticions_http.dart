import 'package:http/http.dart' as http;
import 'dart:convert';

class Peticions {
  Future<List<dynamic>> getProvincies() async {
    try {
      final response = await http.get(Uri.parse(
          'https://node-comarques-rest-server-production.up.railway.app/api/comarques'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> provincies = [];
        for (var provincia in data) {
          provincies.add(
              {'provincia': provincia['provincia'], 'img': provincia['img']});
        }
        return provincies;
      } else {
        throw Exception('Error al obtenir les dades');
      }
    } catch (e) {
      throw Exception('Error de connexió');
    }
  }

  Future<List<dynamic>> getComarques(String provincia) async {
    try {
      final response = await http.get(Uri.parse(
          'https://node-comarques-rest-server-production.up.railway.app/api/comarques/comarquesAmbImatge/$provincia'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> comarques = [];
        for (var comarca in data) {
          comarques.add({'comarca': comarca['nom'], 'img': comarca['img']});
        }
        return comarques;
      } else {
        throw Exception('Error al obtenir les dades');
      }
    } catch (e) {
      throw Exception('Error de connexió');
    }
  }

  Future<List<dynamic>> getInfoComarca(String comarca) async {
    try {
      final response = await http.get(Uri.parse(
          'https://node-comarques-rest-server-production.up.railway.app/api/comarques/infoComarca/$comarca'));
      if (response.statusCode == 200) {
        final infoComarca = json.decode(response.body);
        List<dynamic> comarques = [];
        comarques.add(infoComarca);
        return comarques;
      } else {
        throw Exception('Error al obtenir les dades');
      }
    } catch (e) {
      throw Exception('Error de connexió');
    }
  }
}
