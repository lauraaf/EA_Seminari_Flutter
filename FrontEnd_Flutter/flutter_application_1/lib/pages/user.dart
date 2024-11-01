import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class UserPage extends StatefulWidget{
  @override
  _UserPageState createState() => _UserPageState();
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
      ),
    );
  }
}

class _UserPageState extends State<UserPage> {
  List<dynamic> _data = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // Llamamos a la función para obtener datos cuando la página se carga
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/user')); // Cambia el puerto y la ruta según tu configuración

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
                return ListTile(
                    title: Text(_data[index]['name']), 
                    subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_data[index]['mail']),     // Primer subtítulo (correo)
                      Text(_data[index]['comment']),  // Segundo subtítulo (comentario)
                    ],
                  ),
                );
              },
            ),
    );
  }
}