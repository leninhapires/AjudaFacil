import 'package:flutter/material.dart';
import '/theme.dart';
import 'home.dart';
import 'ajuda.dart';
import 'config.dart';
import 'doacoes.dart';
import 'perfil.dart';

class CursosPage extends StatelessWidget {
  const CursosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('CURSOS DISPONÍVEIS'),
        backgroundColor: AppColors.button,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildCourseCard(
            title: 'Curso de Informática Básica',
            description: 'Aprenda os fundamentos da informática',
            category: 'Tecnologia',
            duration: '20 horas',
          ),
          _buildCourseCard(
            title: 'Curso de Culinária Saudável',
            description: 'Receitas práticas para o dia a dia',
            category: 'Gastronomia',
            duration: '15 horas',
          ),
          _buildCourseCard(
            title: 'Curso de Artesanato',
            description: 'Crie peças decorativas com materiais recicláveis',
            category: 'Artes',
            duration: '12 horas',
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context, 0),
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
                onPressed: () {},
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

  Widget _buildBottomNavigationBar(BuildContext context, int currentIndex) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help),
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
            MaterialPageRoute(builder: (context) => const PerfilPage()),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePageCpf()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AjudaPage()),
          );
        }
      },
    );
  }
}