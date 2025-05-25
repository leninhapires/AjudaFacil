import 'package:flutter/material.dart';
import 'perfil.dart';
import 'ajuda.dart';
import 'cursos.dart';
import 'doacoes.dart';
import 'config.dart';
import '../../theme.dart';
import 'forumcnpj.dart';
import 'home.dart';

class AjudaInstituicaoPage extends StatelessWidget {
  const AjudaInstituicaoPage({Key? key}) : super(key: key);

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
              'AJUDA FÁCIL - INSTITUIÇÃO',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 20),
            Image.asset(
              'assets/image/instituicao.png', // Ícone de instituição
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
              title: 'Gerenciamento Institucional',
              questions: [
                'Como cadastrar nossos serviços?',
                'Como gerenciar doações recebidas?',
                'Como publicar cursos e oportunidades?',
              ],
            ),
            const SizedBox(height: 24),
            _buildHelpSection(
              title: 'Ferramentas para Instituições',
              questions: [
                'Como usar o painel de estatísticas?',
                'Como comunicar necessidades urgentes?',
                'Como atualizar informações da instituição?',
              ],
            ),
            const SizedBox(height: 24),
            _buildHelpSection(
              title: 'Problemas comuns',
              questions: [
                'Problemas com cadastro de serviços',
                'Dificuldades no gerenciamento de voluntários',
                'Como relatar problemas técnicos?',
              ],
            ),
            const SizedBox(height: 24),
            _buildContactCard(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context, 2),
    );
  }

  Widget _buildHelpSection({required String title, required List<String> questions}) {
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
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard() {
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
              'Suporte para Instituições',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Nossa equipe especializada está pronta para ajudar sua instituição',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.secondaryText,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.email),
                  label: const Text('E-mail'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.phone),
                  label: const Text('Telefone'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: const Text('Acessar Central de Ajuda Completa'),
            ),
          ],
        ),
      ),
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
        }
      },
    );
  }
}