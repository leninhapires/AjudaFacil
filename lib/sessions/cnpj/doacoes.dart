import 'package:flutter/material.dart';
import '../../theme.dart';
import 'home.dart';
import 'ajuda.dart';
import 'cursos.dart';
import 'config.dart';
import 'perfil.dart';
import 'forumcnpj.dart';

class DoacoesInstituicaoPage extends StatelessWidget {
  const DoacoesInstituicaoPage({Key? key}) : super(key: key);

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
              Tab(text: 'Receber Doações'),
              Tab(text: 'Campanhas'),
              Tab(text: 'Histórico'),
            ],
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
          ),
        ),
        body: const TabBarView(
          children: [
            _ReceberDoacoesTab(),
            _CampanhasTab(),
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
                  'AJUDA FÁCIL',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Bem-vinda, Instituição!',
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
            title: const Text('Perfil'),
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
            title: const Text('Cursos'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const CursosInstituicaoPage()),
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
                MaterialPageRoute(builder: (context) => const DoacoesInstituicaoPage()),
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

class _ReceberDoacoesTab extends StatelessWidget {
  const _ReceberDoacoesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildDonationOption(
            icon: Icons.monetization_on,
            title: 'Receber Doações em Dinheiro',
            description: 'Configure suas contas para receber transferências',
          ),
          _buildDonationOption(
            icon: Icons.shopping_basket,
            title: 'Receber Doações de Alimentos',
            description: 'Informe seus pontos de coleta',
          ),
          _buildDonationOption(
            icon: Icons.medical_services,
            title: 'Receber Doações de Remédios',
            description: 'Liste medicamentos necessários',
          ),
          _buildDonationOption(
            icon: Icons.volunteer_activism,
            title: 'Receber Doações de Roupas',
            description: 'Informe suas necessidades de vestuário',
          ),
          _buildDonationOption(
            icon: Icons.construction,
            title: 'Receber Doações de Materiais',
            description: 'Liste materiais de construção ou outros itens',
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Ação para configurar doações
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.button,
              foregroundColor: AppColors.buttonText,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text('Configurar Recebimento',
                style: TextStyle(fontSize: 16)),
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

class _CampanhasTab extends StatelessWidget {
  const _CampanhasTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildCampaignCard(
            title: 'Campanha do Agasalho 2023',
            description: 'Arrecadação de roupas de frio para o inverno',
            progress: 0.65,
            donations: 320,
            goal: 500,
          ),
          _buildCampaignCard(
            title: 'Natal Solidário',
            description: 'Arrecadação de brinquedos para crianças carentes',
            progress: 0.35,
            donations: 175,
            goal: 500,
          ),
          _buildCampaignCard(
            title: 'Reforma da Sede',
            description: 'Arrecadação para reforma da nossa sede',
            progress: 0.82,
            donations: 4100,
            goal: 5000,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Ação para criar nova campanha
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.button,
              foregroundColor: AppColors.buttonText,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text('Criar Nova Campanha',
                style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignCard({
    required String title,
    required String description,
    required double progress,
    required int donations,
    required int goal,
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
                color: AppColors.secondaryText,
              ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: AppColors.button,
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$donations/$goal',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                  ),
                ),
                Text(
                  '${(progress * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.button,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Ação para ver detalhes da campanha
                },
                child: const Text('Ver Detalhes'),
              ),
            ),
          ],
        ),
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
          type: 'Doação Recebida',
          description: 'Doação de Roupas - 50 itens',
          date: '15/05/2023',
          donor: 'Maria Silva',
          status: 'Entregue',
          statusColor: Colors.green,
        ),
        _buildHistoryItem(
          type: 'Campanha',
          description: 'Natal Solidário 2022',
          date: '20/12/2022',
          donor: '120 doadores',
          status: 'Concluída',
          statusColor: Colors.green,
        ),
        _buildHistoryItem(
          type: 'Doação Recebida',
          description: 'Transferência Bancária',
          date: '10/05/2023',
          donor: 'João Oliveira',
          status: 'Recebida',
          statusColor: Colors.green,
        ),
        _buildHistoryItem(
          type: 'Campanha',
          description: 'Reforma da Sede',
          date: '01/04/2023',
          donor: '85 doadores',
          status: 'Em andamento',
          statusColor: Colors.orange,
        ),
      ],
    );
  }

  Widget _buildHistoryItem({
    required String type,
    required String description,
    required String date,
    required String donor,
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
            Text(
              'Doador: $donor',
              style: TextStyle(color: AppColors.secondaryText),
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