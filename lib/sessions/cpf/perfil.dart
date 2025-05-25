import 'package:flutter/material.dart';
import 'ajuda.dart';
import 'cursos.dart';
import 'doacoes.dart';
import 'config.dart';
import 'forumcpf.dart'; // Corrigi o nome do arquivo
import '../../theme.dart';
import 'home.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  // Dados do usuário
  String nome = 'Usuário';
  String email = 'usuario@email.com';
  String telefone = '(00) 00000-0000';
  String endereco = 'Rua Exemplo, 123';

  // Controladores
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nomeController.text = nome;
    _emailController.text = email;
    _telefoneController.text = telefone;
    _enderecoController.text = endereco;
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    super.dispose();
  }

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
          children: [
            // Foto do perfil
            Stack(
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/default_profile.png'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.button,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      onPressed: _trocarFoto,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Informações pessoais
            _buildInfoCard(
              title: 'INFORMAÇÕES PESSOAIS',
              children: [
                _buildEditableField('Nome', _nomeController, Icons.person),
                _buildEditableField('E-mail', _emailController, Icons.email),
                _buildEditableField('Telefone', _telefoneController, Icons.phone, TextInputType.phone),
                _buildEditableField('Endereço', _enderecoController, Icons.location_on),
                ElevatedButton(
                  onPressed: _salvarAlteracoes,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: AppColors.buttonText,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('SALVAR ALTERAÇÕES'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Segurança
            _buildInfoCard(
              title: 'SEGURANÇA',
              children: [
                ListTile(
                  leading: Icon(Icons.lock, color: AppColors.button),
                  title: const Text('Alterar Senha'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: _alterarSenha,
                ),
                ListTile(
                  leading: Icon(Icons.security, color: AppColors.button),
                  title: const Text('Privacidade'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ConfiguracoesPage()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Botão de logout
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _confirmarLogout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: AppColors.buttonText,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('SAIR DA CONTA'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(0),
    );
  }

  // Métodos auxiliares
  Widget _buildInfoCard({required String title, required List<Widget> children}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller, IconData icon, [TextInputType? keyboardType]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColors.button),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildBottomNavigationBar(int currentIndex) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
        BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Ajuda'),
      ],
      currentIndex: currentIndex,
      selectedItemColor: AppColors.button,
      onTap: (index) {
        if (index == 1) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePageCpf()));
        } else if (index == 2) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AjudaPage()));
        }
      },
    );
  }

  void _trocarFoto() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text('Tirar Foto'),
            onTap: () {
              Navigator.pop(context);
              // Implementar câmera
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Escolher da Galeria'),
            onTap: () {
              Navigator.pop(context);
              // Implementar galeria
            },
          ),
        ],
      ),
    );
  }

  void _salvarAlteracoes() {
    setState(() {
      nome = _nomeController.text;
      email = _emailController.text;
      telefone = _telefoneController.text;
      endereco = _enderecoController.text;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Alterações salvas com sucesso!')),
    );
  }

  void _alterarSenha() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alterar Senha'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(decoration: const InputDecoration(labelText: 'Senha Atual'), obscureText: true),
            const SizedBox(height: 16),
            TextFormField(decoration: const InputDecoration(labelText: 'Nova Senha'), obscureText: true),
            const SizedBox(height: 16),
            TextFormField(decoration: const InputDecoration(labelText: 'Confirmar Nova Senha'), obscureText: true),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Senha alterada com sucesso!')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.button),
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _confirmarLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sair da Conta'),
        content: const Text('Tem certeza que deseja sair?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
              // Adicionar lógica de logout aqui
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Sair'),
          ),
        ],
      ),
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
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AJUDA FÁCIL', style: TextStyle(color: Colors.white, fontSize: 24)),
                const SizedBox(height: 8),
                Text('Bem-vindo, $nome', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          _buildDrawerItem(Icons.home, 'Início', () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePageCpf()))),
          _buildDrawerItem(Icons.person, 'Perfil', () => Navigator.pop(context)), // Já está no perfil
          _buildDrawerItem(Icons.school, 'Cursos', () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const CursosPage()))),
          _buildDrawerItem(Icons.volunteer_activism, 'Doações', () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DoacoesPage()))),
          _buildDrawerItem(Icons.forum, 'Fórum', () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ForumPage()))),
          _buildDrawerItem(Icons.settings, 'Configurações', () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ConfiguracoesPage()))),
          const Divider(),
          _buildDrawerItem(Icons.exit_to_app, 'Sair', _confirmarLogout),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.button),
      title: Text(title),
      onTap: onTap,
    );
  }
}