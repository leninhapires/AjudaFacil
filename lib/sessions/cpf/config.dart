import 'package:flutter/material.dart';
import '/theme.dart';
import 'home.dart';
import 'ajuda.dart';
import 'cursos.dart';
import 'doacoes.dart';
import 'perfil.dart';

class ConfiguracoesPage extends StatelessWidget {
  const ConfiguracoesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('CONFIGURAÇÕES'),
        backgroundColor: AppColors.button,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSettingsSection(
            title: 'Preferências',
            children: [
              _buildSettingsSwitch(
                title: 'Notificações',
                subtitle: 'Receber alertas e novidades',
                value: true,
              ),
              _buildSettingsSwitch(
                title: 'Modo Escuro',
                subtitle: 'Ativar tema escuro',
                value: false,
              ),
            ],
          ),
          _buildSettingsSection(
            title: 'Privacidade',
            children: [
              _buildSettingsItem(
                icon: Icons.lock,
                title: 'Segurança da Conta',
                onTap: () {},
              ),
              _buildSettingsItem(
                icon: Icons.visibility,
                title: 'Controle de Visibilidade',
                onTap: () {},
              ),
            ],
          ),
          _buildSettingsSection(
            title: 'Sobre',
            children: [
              _buildSettingsItem(
                icon: Icons.info,
                title: 'Termos de Uso',
                onTap: () {},
              ),
              _buildSettingsItem(
                icon: Icons.description,
                title: 'Política de Privacidade',
                onTap: () {},
              ),
              _buildSettingsItem(
                icon: Icons.star,
                title: 'Avaliar Aplicativo',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context, 0),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
        ),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: children),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.button),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildSettingsSwitch({
    required String title,
    required String subtitle,
    required bool value,
  }) {
    return SwitchListTile(
      secondary: Icon(
        value ? Icons.notifications_active : Icons.notifications_off,
        color: AppColors.button,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (bool value) {},
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, int currentIndex) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
        BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Ajuda'),
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
