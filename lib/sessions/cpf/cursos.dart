import 'package:flutter/material.dart';
import '/theme.dart';
import 'home.dart';
import 'ajuda.dart';
import 'config.dart';
import 'doacoes.dart';
import 'perfil.dart';
import 'forumcpf.dart';
import 'package:flutter_application_1/map.dart';

class CursosPage extends StatefulWidget {
  const CursosPage({Key? key}) : super(key: key);

  @override
  State<CursosPage> createState() => _CursosPageState();
}

class _CursosPageState extends State<CursosPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Todas';

  final List<Map<String, String>> _allCourses = [
    {
      'title': 'Curso de Informática Básica',
      'description': 'Aprenda os fundamentos da informática',
      'category': 'Tecnologia',
      'duration': '20 horas',
    },
    {
      'title': 'Curso de Culinária Saudável',
      'description': 'Receitas práticas para o dia a dia',
      'category': 'Gastronomia',
      'duration': '15 horas',
    },
    {
      'title': 'Curso de Artesanato',
      'description': 'Crie peças decorativas com materiais recicláveis',
      'category': 'Artes',
      'duration': '12 horas',
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredCourses = _allCourses.where((course) {
      final matchesSearch = course['title']!
          .toLowerCase()
          .contains(_searchController.text.toLowerCase());
      final matchesCategory =
          _selectedCategory == 'Todas' || course['category'] == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: _buildDrawer(context),
      appBar: AppBar(
        backgroundColor: AppColors.button,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/logo.png',
              height: 30,
            ),
            const SizedBox(width: 8),
            const Text(
              'AJUDA FÁCIL',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 20),
            Image.asset(
              'assets/image/cv.png',
              height: 70,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔍 Barra de Pesquisa
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar curso...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 12),

            // ⛳ Filtro por Categoria
            Row(
              children: [
                const Text("Filtrar por: "),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _selectedCategory,
                  items: <String>['Todas', 'Tecnologia', 'Gastronomia', 'Artes']
                      .map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 📋 Lista de Cursos Filtrada
            Expanded(
              child: ListView.builder(
                itemCount: filteredCourses.length,
                itemBuilder: (context, index) {
                  final course = filteredCourses[index];
                  return _buildCourseCard(
                    title: course['title']!,
                    description: course['description']!,
                    category: course['category']!,
                    duration: course['duration']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context), // Alterado para refletir a posição da página atual
    );
  }

  Widget _buildCourseCard({
    required String title,
    required String description,
    required String category,
    required String duration,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.secondaryText,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildInfoChip(icon: Icons.category, text: category),
                const SizedBox(width: 8),
                _buildInfoChip(icon: Icons.timer, text: duration),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Adicionar ação de inscrição aqui
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.button,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Inscrever-se'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String text}) {
    return Chip(
      avatar: Icon(icon, size: 18, color: AppColors.button),
      label: Text(text),
      backgroundColor: AppColors.button.withOpacity(0.1),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
        BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Mapa'),
        BottomNavigationBarItem(icon: Icon(Icons.help_outline), label: 'Ajuda'),
      ],
      currentIndex: 1, // Índice do item ativo (Início)
      selectedItemColor: AppColors.button,
      unselectedItemColor: Colors.grey,
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const PerfilPage()),
            );
            break;
          case 1:
            // Já está na tela inicial
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MapaPage()),
            );
            break;
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AjudaPage()),
            );
            break;
        }
      },
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.button),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'AJUDA FÁCIL',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Bem-vindo, Usuário!',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
         ListTile(
            leading: Icon(Icons.home, color: AppColors.button),
            title: const Text('Início'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePageCpf()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: AppColors.button),
            title: const Text('Perfil'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const PerfilPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.school, color: AppColors.button),
            title: const Text('Cursos'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const CursosPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.volunteer_activism, color: AppColors.button),
            title: const Text('Doações'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DoacoesPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.forum, color: AppColors.button),
            title: const Text('Fórum'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ForumPage())
                
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.location_on, color: AppColors.button),
            title: const Text('Mapa de Ajuda'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MapaPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: AppColors.button),
            title: const Text('Configurações'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ConfiguracoesPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: AppColors.button),
            title: const Text('Sair'),
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }
}