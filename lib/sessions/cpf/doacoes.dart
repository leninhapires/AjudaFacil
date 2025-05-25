import 'package:flutter/material.dart';
import '/theme.dart';
import 'home.dart';
import 'ajuda.dart';
import 'cursos.dart';
import 'config.dart';
import 'perfil.dart';
import 'forumcpf.dart';

class DoacoesPage extends StatelessWidget {
  const DoacoesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Quero Doar'),
              Tab(text: 'Solicitar'),
              Tab(text: 'Histórico'),
            ],
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
          ),
        ),
        body: const TabBarView(
          children: [
            _QueroDoarTab(),
            _SolicitarDoacoesTab(),
            _HistoricoTab(),
          ],
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context, 0),
      ),
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

class _QueroDoarTab extends StatelessWidget {
  const _QueroDoarTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildDonationOption(
            icon: Icons.monetization_on,
            title: 'Doação em Dinheiro',
            description: 'Contribua com qualquer valor',
          ),
          _buildDonationOption(
            icon: Icons.shopping_basket,
            title: 'Doação de Alimentos',
            description: 'Doe itens não perecíveis',
          ),
          _buildDonationOption(
            icon: Icons.medical_services,
            title: 'Doação de Remédios',
            description: 'Medicamentos com validade em dia',
          ),
          _buildDonationOption(
            icon: Icons.volunteer_activism,
            title: 'Doação de Roupas',
            description: 'Roupas em bom estado de conservação',
          ),
        ],
      ),
    );
  }

  Widget _buildDonationOption({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, size: 40, color: AppColors.button),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(color: AppColors.secondaryText),
        ),
        trailing: const Icon(Icons.chevron_right),
        contentPadding: const EdgeInsets.all(16),
        onTap: () {
          // Ação ao clicar em uma opção de doação
        },
      ),
    );
  }
}

class _SolicitarDoacoesTab extends StatelessWidget {
  const _SolicitarDoacoesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildRequestOption(
            icon: Icons.monetization_on,
            title: 'Necessito de Ajuda Financeira',
            description: 'Solicitar apoio financeiro',
          ),
          _buildRequestOption(
            icon: Icons.shopping_basket,
            title: 'Necessito de Alimentos',
            description: 'Solicitar cesta básica ou alimentos',
          ),
          _buildRequestOption(
            icon: Icons.medical_services,
            title: 'Necessito de Remédios',
            description: 'Solicitar medicamentos específicos',
          ),
          _buildRequestOption(
            icon: Icons.volunteer_activism,
            title: 'Necessito de Roupas',
            description: 'Solicitar roupas ou agasalhos',
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Ação para criar nova solicitação
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.button,
              foregroundColor: AppColors.buttonText,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text('Nova Solicitação',
                style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestOption({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, size: 40, color: AppColors.button),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(color: AppColors.secondaryText),
        ),
        trailing: const Icon(Icons.chevron_right),
        contentPadding: const EdgeInsets.all(16),
        onTap: () {
          // Ação ao clicar em uma opção de solicitação
        },
      ),
    );
  }
}

class _HistoricoTab extends StatelessWidget {
  const _HistoricoTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildHistoryItem(
          type: 'Doação',
          description: 'Doação de Roupas',
          date: '10/05/2023',
          status: 'Concluído',
          statusColor: Colors.green,
        ),
        _buildHistoryItem(
          type: 'Solicitação',
          description: 'Cesta Básica',
          date: '05/05/2023',
          status: 'Em andamento',
          statusColor: Colors.orange,
        ),
        _buildHistoryItem(
          type: 'Doação',
          description: 'Doação em Dinheiro',
          date: '01/05/2023',
          status: 'Concluído',
          statusColor: Colors.green,
        ),
        _buildHistoryItem(
          type: 'Solicitação',
          description: 'Medicamentos',
          date: '20/04/2023',
          status: 'Cancelado',
          statusColor: Colors.red,
        ),
      ],
    );
  }

  Widget _buildHistoryItem({
    required String type,
    required String description,
    required String date,
    required String status,
    required Color statusColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  type,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.button,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(color: AppColors.secondaryText),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Status: ',
                  style: TextStyle(color: AppColors.secondaryText),
                ),
                Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}