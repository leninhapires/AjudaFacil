import 'package:flutter/material.dart';
import '../../theme.dart';
import 'ajuda.dart';
import 'cursos.dart';
import 'doacoes.dart';
import 'config.dart';
import 'perfil.dart';
import 'home.dart';
import 'forumcpf.dart';
import 'package:flutter_application_1/map.dart';

class ForumPage extends StatelessWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          // Barra de pesquisa e filtro
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Pesquisar tópicos...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    // Ação para filtrar
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Botão para criar novo tópico
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // Navegar para tela de criação de tópico
              },
              icon: const Icon(Icons.add),
              label: const Text('Criar Novo Tópico'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.button,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // Lista de tópicos
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildTopicCard(
                  title: 'Como ajudar pessoas em situação de rua?',
                  author: 'Maria Silva',
                  replies: 24,
                  lastActivity: '2 horas atrás',
                  isPinned: true,
                ),
                _buildTopicCard(
                  title: 'Doações de alimentos - Melhores práticas',
                  author: 'João Oliveira',
                  replies: 15,
                  lastActivity: '5 horas atrás',
                  isPinned: true,
                ),
                _buildTopicCard(
                  title: 'Voluntariado aos finais de semana',
                  author: 'Carlos Ferreira',
                  replies: 8,
                  lastActivity: 'Ontem',
                ),
                _buildTopicCard(
                  title: 'Campanha de agasalhos 2023',
                  author: 'Ana Paula',
                  replies: 32,
                  lastActivity: '2 dias atrás',
                ),
                _buildTopicCard(
                  title: 'Experiências com trabalho voluntário',
                  author: 'Roberto Almeida',
                  replies: 19,
                  lastActivity: '3 dias atrás',
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar para tela de criação de tópico
        },
        backgroundColor: AppColors.button,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildTopicCard({
    required String title,
    required String author,
    required int replies,
    required String lastActivity,
    bool isPinned = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navegar para tela do tópico
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isPinned)
                Row(
                  children: [
                    const Icon(Icons.push_pin, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      'FIXADO',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              if (isPinned) const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.button.withOpacity(0.2),
                    child: Text(
                      author[0],
                      style: TextStyle(
                        color: AppColors.button,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    author,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.chat_bubble_outline, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '$replies respostas',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  Text(
                    lastActivity,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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