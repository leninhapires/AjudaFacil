import 'package:flutter/material.dart';
import '../../theme.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  // Dados do usuário (inicialmente vazios)
  String nome = 'Usuário';
  String email = 'usuario@email.com';
  String telefone = '(00) 00000-0000';
  String endereco = 'Rua Exemplo, 123';

  // Controladores para os campos editáveis
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();

  // Variável para a foto do perfil
  String fotoPerfil = 'assets/default_profile.png'; // Substitua pelo caminho da sua imagem padrão

  @override
  void initState() {
    super.initState();
    // Inicializa os controladores com os valores atuais
    _nomeController.text = nome;
    _emailController.text = email;
    _telefoneController.text = telefone;
    _enderecoController.text = endereco;
  }

  @override
  void dispose() {
    // Limpa os controladores quando o widget for descartado
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
      appBar: AppBar(
        title: const Text('MEU PERFIL'),
        backgroundColor: AppColors.button,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _salvarAlteracoes,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Seção da foto do perfil
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(fotoPerfil),
                  backgroundColor: AppColors.button.withOpacity(0.2),
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

            // Card de informações pessoais
            _buildInfoCard(
              title: 'INFORMAÇÕES PESSOAIS',
              children: [
                _buildEditableField(
                  label: 'Nome Completo',
                  controller: _nomeController,
                  icon: Icons.person,
                ),
                _buildEditableField(
                  label: 'E-mail',
                  controller: _emailController,
                  icon: Icons.email,
                ),
                _buildEditableField(
                  label: 'Telefone',
                  controller: _telefoneController,
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),
                _buildEditableField(
                  label: 'Endereço',
                  controller: _enderecoController,
                  icon: Icons.location_on,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Card de segurança
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
                  onTap: () {
                    // Navegar para tela de privacidade
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Botão para sair
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _confirmarLogout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('SAIR DA CONTA'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(0), // Índice 0 para Perfil selecionado
    );
  }

  Widget _buildInfoCard({required String title, required List<Widget> children}) {
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
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColors.button),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        keyboardType: keyboardType,
        style: TextStyle(color: AppColors.primaryText),
      ),
    );
  }

  Widget _buildBottomNavigationBar(int currentIndex) {
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
        if (index == 1) {
          // Navegar para Home
          Navigator.pushReplacementNamed(context, '/home');
        } else if (index == 2) {
          // Navegar para Ajuda
          Navigator.pushNamed(context, '/ajuda');
        }
        // Se for 0 (Perfil), já estamos na tela
      },
    );
  }

  void _trocarFoto() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Tirar Foto'),
                onTap: () {
                  Navigator.pop(context);
                  // Implementar lógica para tirar foto
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Escolher da Galeria'),
                onTap: () {
                  Navigator.pop(context);
                  // Implementar lógica para escolher da galeria
                },
              ),
            ],
          ),
        );
      },
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
      const SnackBar(
        content: Text('Alterações salvas com sucesso!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _alterarSenha() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alterar Senha'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Senha Atual',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nova Senha',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Confirmar Nova Senha',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Senha alterada com sucesso!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.button,
              ),
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _confirmarLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sair da Conta'),
          content: const Text('Tem certeza que deseja sair da sua conta?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Implementar lógica de logout
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Sair'),
            ),
          ],
        );
      },
    );
  }
}