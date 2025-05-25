import 'package:flutter/material.dart';
import 'perfil.dart';
import 'ajuda.dart';
import 'cursos.dart';
import 'doacoes.dart';
import 'config.dart';
import 'home.dart';
import '../../theme.dart';
import 'forumcnpj.dart';

class CursosInstituicaoPage extends StatefulWidget {
  const CursosInstituicaoPage({Key? key}) : super(key: key);

  @override
  State<CursosInstituicaoPage> createState() => _CursosInstituicaoPageState();
}

class _CursosInstituicaoPageState extends State<CursosInstituicaoPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Todas';
  final List<Map<String, String>> _allCourses = [
    {
      'title': 'Curso de Informática Básica',
      'description': 'Aprenda os fundamentos da informática',
      'category': 'Tecnologia',
      'duration': '20 horas',
      'vacancies': '25 vagas',
    },
    {
      'title': 'Curso de Culinária Saudável',
      'description': 'Receitas práticas para o dia a dia',
      'category': 'Gastronomia',
      'duration': '15 horas',
      'vacancies': '15 vagas',
    },
    {
      'title': 'Curso de Artesanato',
      'description': 'Crie peças decorativas com materiais recicláveis',
      'category': 'Artes',
      'duration': '12 horas',
      'vacancies': '20 vagas',
    },
  ];

  // Controllers para o formulário de novo curso
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _vacanciesController = TextEditingController();
  String _newCourseCategory = 'Tecnologia';

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
              'AJUDA FÁCIL - INSTITUIÇÃO',
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
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddCourseDialog(context),
          ),
        ],
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
              child: filteredCourses.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhum curso encontrado',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredCourses.length,
                      itemBuilder: (context, index) {
                        final course = filteredCourses[index];
                        return _buildCourseCard(
                          context: context,
                          title: course['title']!,
                          description: course['description']!,
                          category: course['category']!,
                          duration: course['duration']!,
                          vacancies: course['vacancies']!,
                          onDelete: () => _deleteCourse(index),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context, 1),
    );
  }

  void _showAddCourseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Novo Curso'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Título do Curso',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _newCourseCategory,
                  items: <String>['Tecnologia', 'Gastronomia', 'Artes']
                      .map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _newCourseCategory = newValue!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Categoria',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _durationController,
                  decoration: const InputDecoration(
                    labelText: 'Duração (horas)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _vacanciesController,
                  decoration: const InputDecoration(
                    labelText: 'Número de Vagas',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _addNewCourse();
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _addNewCourse() {
    setState(() {
      _allCourses.add({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'category': _newCourseCategory,
        'duration': '${_durationController.text} horas',
        'vacancies': '${_vacanciesController.text} vagas',
      });
    });
    _titleController.clear();
    _descriptionController.clear();
    _durationController.clear();
    _vacanciesController.clear();
  }

  void _deleteCourse(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remover Curso'),
          content: Text(
              'Tem certeza que deseja remover o curso "${_allCourses[index]['title']}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                setState(() {
                  _allCourses.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text('Remover'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCourseCard({
    required BuildContext context,
    required String title,
    required String description,
    required String category,
    required String duration,
    required String vacancies,
    required VoidCallback onDelete,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
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
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildInfoChip(icon: Icons.category, text: category),
                _buildInfoChip(icon: Icons.timer, text: duration),
                _buildInfoChip(icon: Icons.people, text: vacancies),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Ação para editar curso
                    _editCourse(context, title, description, category, duration, vacancies);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Editar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Ação para visualizar inscritos
                    _showParticipantsDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Inscritos'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _editCourse(BuildContext context, String title, String description, 
      String category, String duration, String vacancies) {
    _titleController.text = title;
    _descriptionController.text = description;
    _newCourseCategory = category;
    _durationController.text = duration.replaceAll(' horas', '');
    _vacanciesController.text = vacancies.replaceAll(' vagas', '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Curso'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Título do Curso',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _newCourseCategory,
                  items: <String>['Tecnologia', 'Gastronomia', 'Artes']
                      .map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _newCourseCategory = newValue!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Categoria',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _durationController,
                  decoration: const InputDecoration(
                    labelText: 'Duração (horas)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _vacanciesController,
                  decoration: const InputDecoration(
                    labelText: 'Número de Vagas',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implementar lógica de atualização
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Curso atualizado com sucesso!')),
                );
              },
              child: const Text('Salvar Alterações'),
            ),
          ],
        );
      },
    );
  }

  void _showParticipantsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Participantes Inscritos'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 5, // Número fictício de participantes
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text('Participante ${index + 1}'),
                  subtitle: const Text('email@exemplo.com'),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoChip({required IconData icon, required String text}) {
    return Chip(
      avatar: Icon(icon, size: 18, color: AppColors.button),
      label: Text(text),
      backgroundColor: AppColors.button.withOpacity(0.1),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, int currentIndex) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Perfil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help_outline),
          label: 'Ajuda',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: AppColors.button,
      unselectedItemColor: Colors.grey,
      onTap: (int index) {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PerfilInstituicaoPage()),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePageInstituicao()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AjudaInstituicaoPage()),
          );
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
                  'AJUDA FÁCIL - INSTITUIÇÃO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Bem-vindo, Instituição!',
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
                MaterialPageRoute(builder: (context) => const HomePageInstituicao()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.business, color: AppColors.button),
            title: const Text('Perfil Institucional'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const PerfilInstituicaoPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.school, color: AppColors.button),
            title: const Text('Cursos e Oportunidades'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.card_giftcard, color: AppColors.button),
            title: const Text('Gerenciar Doações'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DoacoesInstituicaoPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.forum, color: AppColors.button),
            title: const Text('Fórum Institucional'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ForumInstituicaoPage()),
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
                MaterialPageRoute(builder: (context) => const ConfiguracoesInstituicaoPage()),
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