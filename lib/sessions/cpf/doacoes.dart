import 'package:flutter/material.dart';
import '/theme.dart';
import 'home.dart';
import 'ajuda.dart';
import 'cursos.dart';
import 'config.dart';
import 'perfil.dart';
class DoacoesPage extends StatelessWidget {
  const DoacoesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('FAZER DOAÇÃO'),
        backgroundColor: AppColors.button,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
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
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context, 0),
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
        onTap: () {},
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
}