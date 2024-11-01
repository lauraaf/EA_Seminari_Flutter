import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ExperienciesPage extends StatefulWidget{
  @override
  _ExperienciesPageState createState() => _ExperienciesPageState();
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Experiencies'),
      ),
    );
  }
}

class _ExperienciesPageState extends State<ExperienciesPage> {
  List<dynamic> _data = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // Llamamos a la función para obtener datos cuando la página se carga
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/experiencias')); // Cambia el puerto y la ruta según tu configuración

      if (response.statusCode == 200) {
        // Decodifica la respuesta JSON
        setState(() {
          _data = json.decode(response.body);
        });
      } else {
        throw Exception('Error al cargar los datos');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Datos de la API Local')),
      body: _data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                final owner = _data[index]['owner'];
                return ListTile(
                    title: Text(_data[index]['description']), 
                    subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (owner != null) ...[
                      Text('Owner:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Name: ${owner['name']}'),
                      ],     
                      Text('Participants:', style: TextStyle(fontWeight: FontWeight.bold)),
                      ...(_data[index]['participants'] as List).map((participants) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name: ${participants['name']}'),
                            SizedBox(height: 4), 
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                );
              },
            ),
    );
  }
}