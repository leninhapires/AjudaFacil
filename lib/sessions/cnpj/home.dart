import 'package:flutter/material.dart';
import 'perfil.dart';
import 'ajuda.dart';
import 'cursos.dart';
import 'doacoes.dart';
import 'config.dart';
import '../../theme.dart';
import 'forumcnpj.dart';
import 'package:flutter_application_1/map.dart';

class HomePageInstituicao extends StatelessWidget {
  const HomePageInstituicao({Key? key}) : super(key: key);

  // Lista de cores para os cards
  final List<Color> cardColors = const [
    Color(0xFF4285F4), // Azul
    Color(0xFF34A853), // Verde
    Color(0xFFEA4335), // Vermelho
    Color.fromARGB(255, 53, 53, 234), // Amarelo mostarda

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
              'assets/image/cv.png', // Alterado para ícone de instituição
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
              'Olá, Instituição!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            Text(
              'Bem-vindo(a) ao Ajuda Fácil! Aqui você pode gerenciar suas ações sociais, cadastrar oportunidades e conectar-se com quem precisa de ajuda.',
              style: TextStyle(fontSize: 16, color: AppColors.secondaryText),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Card OFERECER AJUDA
            _buildFeatureCard(
              title: 'OFERECER AJUDA',
              description: 'Cadastre serviços e apoio que sua instituição oferece.',
              buttonText: 'Gerenciar',
              icon: Icons.add_circle_outline,
              color: cardColors[0],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AjudaInstituicaoPage()),
                );
              },
            ),
            const SizedBox(height: 16),

            // Card RECEBER DOAÇÕES
            _buildFeatureCard(
              title: 'RECEBER DOAÇÕES',
              description: 'Cadastre itens necessários e gerencie doações recebidas.',
              buttonText: 'Gerenciar',
              icon: Icons.card_giftcard,
              color: cardColors[1],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DoacoesInstituicaoPage()),
                );
              },
            ),
            const SizedBox(height: 16),

            // Card ALERTAS
            _buildFeatureCard(
              title: 'PUBLICAR ALERTAS',
              description: 'Comunique emergências e necessidades urgentes.',
              buttonText: 'Acessar',
              icon: Icons.notifications_active,
              color: cardColors[2],
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Criar Alerta'),
                    content: const Text('O que você gostaria de comunicar à comunidade?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancelar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Lógica para criar alerta
                        },
                        child: const Text('Publicar'),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // Card localizar DOAÇÕES
            _buildFeatureCard(
              title: 'PROUCURAR LOCAL PARA DOAÇÃO',
              description: 'Proucure pessoas ou instituições perto de você para doar.',
              buttonText: 'Localizar',
              icon: Icons.maps_home_work_outlined,
              color: cardColors[3],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapaPage()),
                );
              },
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 24),
            
            // Seção de Cursos/Oportunidades
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
                      'CURSOS E OPORTUNIDADES',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Gerencie os cursos e oportunidades oferecidos por sua instituição:',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    
                    // Curso de exemplo 1
                    ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.school)),
                      title: const Text('Curso de Capacitação Profissional'),
                      subtitle: const Text('25 vagas disponíveis'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CursosInstituicaoPage()),
                        );
                      },
                    ),
                    
                    // Oportunidade de exemplo 2
                    ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.work)),
                      title: const Text('Oficina de Artesanato'),
                      subtitle: const Text('Toda quarta-feira, 14h'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CursosInstituicaoPage()),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Botão para gerenciar cursos
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CursosInstituicaoPage()),
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
                        child: const Text('Gerenciar Cursos e Oportunidades'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Seção de Estatísticas
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
                      'SUA INSTITUIÇÃO EM NÚMEROS',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatCard('152', 'Pessoas ajudadas'),
                        _buildStatCard('28', 'Doações recebidas'),
                        _buildStatCard('5', 'Cursos oferecidos'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Continue seu importante trabalho!',
                      style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
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

  Widget _buildStatCard(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
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
              MaterialPageRoute(builder: (context) => const PerfilInstituicaoPage()),
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
              MaterialPageRoute(builder: (context) => const AjudaInstituicaoPage()),
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
                  'AJUDA FÁCIL - INSTITUIÇÃO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Bem-vindo(a), Instituição!',
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
            title: const Text('Perfil da Instituição'),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const CursosInstituicaoPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.card_giftcard, color: AppColors.button),
            title: const Text('Doações Recebidas'),
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
            leading: Icon(Icons.map, color: AppColors.button),
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