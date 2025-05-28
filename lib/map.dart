import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importe o Provider
import 'cadastro.dart';
import 'login.dart';
import 'theme.dart';
import 'sessions/cpf/home.dart';
import 'sessions/cnpj/home.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';




class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  late GoogleMapController mapController;
  Location location = Location();
  LatLng? _currentPosition;
  bool _loading = true;
  Set<Marker> _markers = {};
  
  // Filtros
  bool _showInstitutions = true;
  bool _showPeople = true;
  
  // Dados de exemplo (substitua por dados reais da sua aplicação)
  final List<Map<String, dynamic>> _institutions = [
    {
      'id': '1',
      'name': 'ONG Esperança',
      'position': LatLng(-23.5505, -46.6333),
      'type': 'institution',
    },
    {
      'id': '2',
      'name': 'Abrigo São Francisco',
      'position': LatLng(-23.5515, -46.6343),
      'type': 'institution',
    },
  ];
  
  final List<Map<String, dynamic>> _people = [
    {
      'id': 'p1',
      'name': 'João Silva',
      'position': LatLng(-23.5508, -46.6338),
      'type': 'person',
      'needs': 'Alimentos e roupas',
    },
    {
      'id': 'p2',
      'name': 'Maria Souza',
      'position': LatLng(-23.5512, -46.6328),
      'type': 'person',
      'needs': 'Medicamentos',
    },
  ];

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await location.getLocation();
    setState(() {
      _currentPosition = LatLng(locationData.latitude!, locationData.longitude!);
      _loading = false;
      _updateMarkers();
    });
  }

  void _updateMarkers() {
    _markers.clear();
    
    // Adiciona marcador da posição atual
    if (_currentPosition != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('current'),
          position: _currentPosition!,
          infoWindow: const InfoWindow(title: 'Sua posição'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }
    
    // Adiciona marcadores de instituições se o filtro estiver ativo
    if (_showInstitutions) {
      for (var institution in _institutions) {
        _markers.add(
          Marker(
            markerId: MarkerId(institution['id']),
            position: institution['position'],
            infoWindow: InfoWindow(title: institution['name']),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          ),
        );
      }
    }
    
    // Adiciona marcadores de pessoas se o filtro estiver ativo
    if (_showPeople) {
      for (var person in _people) {
        _markers.add(
          Marker(
            markerId: MarkerId(person['id']),
            position: person['position'],
            infoWindow: InfoWindow(
              title: person['name'],
              snippet: person['needs'] ?? 'Precisa de ajuda',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Ajuda'),
        backgroundColor: AppColors.button,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Filtrar Marcadores'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CheckboxListTile(
                        title: const Text('Mostrar Instituições'),
                        value: _showInstitutions,
                        onChanged: (value) {
                          setState(() {
                            _showInstitutions = value!;
                            _updateMarkers();
                          });
                          Navigator.pop(context);
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Mostrar Pessoas'),
                        value: _showPeople,
                        onChanged: (value) {
                          setState(() {
                            _showPeople = value!;
                            _updateMarkers();
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Fechar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _currentPosition == null
              ? const Center(child: Text('Não foi possível obter a localização'))
              : GoogleMap(
                  onMapCreated: (controller) {
                    setState(() {
                      mapController = controller;
                    });
                  },
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition!,
                    zoom: 15,
                  ),
                  markers: _markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
    );
  }
}