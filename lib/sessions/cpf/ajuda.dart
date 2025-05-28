import 'package:flutter/material.dart';
import '/theme.dart';
import 'home.dart';
import 'config.dart';
import 'cursos.dart';
import 'doacoes.dart';
import 'perfil.dart';
import 'forumcpf.dart';
import 'package:flutter_application_1/map.dart';

class AjudaPage extends StatelessWidget {
  const AjudaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHelpSection(
              title: 'Como usar o aplicativo',
              questions: [
                'Como encontrar ONGs próximas?',
                'Como fazer uma doação?',
                'Como me cadastrar em cursos?',
              ],
              context: context,
            ),
            const SizedBox(height: 24),
            _buildHelpSection(
              title: 'Problemas comuns',
              questions: [
                'Não consigo fazer login',
                'O aplicativo está travando',
                'Como atualizar meus dados?',
              ],
              context: context,
            ),
            const SizedBox(height: 24),
            _buildContactCard(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      drawer: _buildDrawer(context),
    );
  }

  Widget _buildHelpSection({
    required String title,
    required List<String> questions,
    required BuildContext context,
  }) {
    return Card(
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
            const SizedBox(height: 12),
            ...questions.map((question) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: InkWell(
                onTap: () => _showHelpDialog(context, question),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.help_outline, color: Colors.grey),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          question,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: AppColors.button.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(Icons.headset_mic, size: 40, color: Colors.blue),
            const SizedBox(height: 12),
            Text(
              'Precisa de mais ajuda?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Entre em contato com nosso suporte',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.secondaryText,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _contactSupport(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.button,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Falar com atendente'),
            ),
          ],
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
      currentIndex: 3, // Changed to 3 since this is the AjudaPage
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePageCpf()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MapaPage()),
            );
            break;
          case 3:
            // Already on help page
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
                MaterialPageRoute(builder: (context) => const ForumPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.location_on, color: AppColors.button),
            title: const Text('Mapa de Ajuda'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
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

  void _showHelpDialog(BuildContext context, String question) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(question),
        content: Text(
          _getHelpAnswer(question),
          style: TextStyle(color: AppColors.secondaryText),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  String _getHelpAnswer(String question) {
    // Add your help answers here
    switch (question) {
      case 'Como encontrar ONGs próximas?':
        return 'Vá para a página do Mapa e visualize as ONGs próximas à sua localização.';
      case 'Como fazer uma doação?':
        return 'Navegue até a página de Doações e siga as instruções para realizar sua contribuição.';
      case 'Como me cadastrar em cursos?':
        return 'Acesse a página de Cursos, escolha o curso desejado e clique em "Inscrever-se".';
      case 'Não consigo fazer login':
        return 'Verifique seu e-mail e senha. Se o problema persistir, clique em "Esqueci minha senha".';
      case 'O aplicativo está travando':
        return 'Tente reiniciar o aplicativo. Se o problema continuar, reinstale o aplicativo.';
      case 'Como atualizar meus dados?':
        return 'Vá para a página de Perfil e clique no ícone de edição para atualizar suas informações.';
      default:
        return 'Entre em contato com nosso suporte para obter ajuda com este problema.';
    }
  }

  void _contactSupport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contato de Suporte'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Entre em contato conosco através de:'),
            const SizedBox(height: 16),
            _buildContactOption(Icons.email, 'suporte@ajudafacil.com.br'),
            _buildContactOption(Icons.phone, '(11) 1234-5678'),
            _buildContactOption(Icons.chat, 'Chat online no aplicativo'),
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
  }

  Widget _buildContactOption(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.button),
          const SizedBox(width: 12),
          Text(text),
        ],
      ),
    );
  }
}