import 'package:flutter/material.dart';
import 'package:info_comarques/data/peticions_http.dart';

// Aquest widget mostra la informació d'una comarca específica.
//
// Aquest widget és utilitzat per a mostrar la informació detallada d'una comarca,
// incloent la seva imatge, nom, capital i descripció.
//
// Requereix el paràmetre [comarca] per a especificar la comarca de la qual es vol mostrar la informació.

class InfoComarques extends StatelessWidget {
  final String comarca;

  const InfoComarques({super.key, required this.comarca});

  Future<List<dynamic>> _getInfoComarca(String comarca) async {
    Peticions peticions = Peticions();
    return await peticions.getInfoComarca(comarca);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _getInfoComarca(comarca),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final comarques = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Informació Comarques'),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.webp"),
                  opacity: 0.2,
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Image.network(
                          comarques[0]['img'],
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          comarques[0]['comarca'],
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Capital: ${comarques[0]['capital']}',
                          style: const TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          comarques[0]['desc'],
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.indigo[200],
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.info),
                  label: 'La comarca',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.sunny),
                  label: 'Informació i oratge',
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Informació Comarques'),
            ),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Informació Comarques'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
