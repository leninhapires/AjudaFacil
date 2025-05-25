import 'package:flutter/material.dart';
import 'perfil.dart';
import 'ajuda.dart';
import 'cursos.dart';
import 'doacoes.dart';
import 'config.dart';
import '../../theme.dart';
import 'forumcpf.dart';

class HomePageCpf extends StatelessWidget {
  const HomePageCpf({Key? key}) : super(key: key);

  // Lista de cores para os cards
  final List<Color> cardColors = const [
    Color(0xFF4285F4), // Azul
    Color(0xFF34A853), // Verde
    Color(0xFFEA4335), // Vermelho
  ];

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Mensagem de boas-vindas
            Text(
              'Olá, Usuário!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            Text(
              'Seja bem-vindo(a) ao Ajuda Fácil! Estamos aqui para conectar você a uma rede de apoio, oportunidades e solidariedade.',
              style: TextStyle(fontSize: 16, color: AppColors.secondaryText),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Card BUSCAR AJUDA
            _buildFeatureCard(
              title: 'BUSCAR AJUDA',
              description: 'Encontre ONCE e apoio perto de você.',
              buttonText: 'Acessar Agora',
              icon: Icons.search,
              color: cardColors[0],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AjudaPage()),
                );
              },
            ),
            const SizedBox(height: 16),

            // Card FAZER DOAÇÃO
            _buildFeatureCard(
              title: 'FAZER DOAÇÃO',
              description: 'Contribua e faça a diferença na vida de alguém.',
              buttonText: 'Acessar Agora',
              icon: Icons.volunteer_activism,
              color: cardColors[1],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DoacoesPage()),
                );
              },
            ),
            const SizedBox(height: 16),

            // Card ALERTAS
            _buildFeatureCard(
              title: 'ALERTAS',
              description: 'Acesso informações sobre emergências e suporte rápido.',
              buttonText: 'Acessar Agora',
              icon: Icons.notifications,
              color: cardColors[2],
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Alertas'),
                    content: const Text('Nenhum alerta no momento.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            
            // Prévia do Fórum
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'FÓRUM DA COMUNIDADE',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Participe das discussões com outros membros:',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    
                    // Tópico de exemplo 1
                    ListTile(
                      leading: const CircleAvatar(child: Text('M')),
                      title: const Text('Como ajudar pessoas em situação de rua?'),
                      subtitle: const Text('24 respostas • 2 horas atrás'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ForumPage()),
                        );
                      },
                    ),
                    
                    // Tópico de exemplo 2
                    ListTile(
                      leading: const CircleAvatar(child: Text('J')),
                      title: const Text('Doações de alimentos - Melhores práticas'),
                      subtitle: const Text('15 respostas • 5 horas atrás'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ForumPage()),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Botão para acessar o fórum completo
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ForumPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.button,
                          foregroundColor: AppColors.buttonText,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Acessar o Fórum Completo'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required String description,
    required String buttonText,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 28, color: Colors.white),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: Text(buttonText),
              ),
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
        BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Ajuda'),
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
                MaterialPageRoute(builder: (context) => const ForumPage()),
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