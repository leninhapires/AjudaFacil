import 'package:flutter/material.dart';
import 'ajuda.dart';
import 'cursos.dart';
import 'doacoes.dart';
import 'config.dart';
import 'forumcnpj.dart';
import '../../theme.dart';
import 'home.dart';

class PerfilInstituicaoPage extends StatefulWidget {
  const PerfilInstituicaoPage({Key? key}) : super(key: key);

  @override
  _PerfilInstituicaoPageState createState() => _PerfilInstituicaoPageState();
}

class _PerfilInstituicaoPageState extends State<PerfilInstituicaoPage> {
  // Dados da instituição
  String nome = 'Instituição';
  String cnpj = '00.000.000/0000-00';
  String email = 'instituicao@email.com';
  String telefone = '(00) 00000-0000';
  String endereco = 'Rua Exemplo, 123';
  String areaAtuacao = 'Assistência Social';
  String descricao = 'Descrição da instituição e seu trabalho';

  // Controladores
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _areaAtuacaoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nomeController.text = nome;
    _cnpjController.text = cnpj;
    _emailController.text = email;
    _telefoneController.text = telefone;
    _enderecoController.text = endereco;
    _areaAtuacaoController.text = areaAtuacao;
    _descricaoController.text = descricao;
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cnpjController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    _areaAtuacaoController.dispose();
    _descricaoController.dispose();
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
            Image.asset('assets/image/logo.png', height: 30),
            const SizedBox(width: 8),
            const Text(
              'AJUDA FÁCIL',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 20),
            Image.asset('assets/image/cv.png', height: 70),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Logo da instituição
            Stack(
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/default_institution.png'),
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
                      onPressed: _trocarLogo,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Informações da instituição
            _buildInfoCard(
              title: 'INFORMAÇÕES DA INSTITUIÇÃO',
              children: [
                _buildEditableField(
                  'Nome da Instituição',
                  _nomeController,
                  Icons.business,
                ),
                _buildEditableField(
                  'CNPJ',
                  _cnpjController,
                  Icons.assignment,
                  TextInputType.number,
                ),
                _buildEditableField('E-mail', _emailController, Icons.email),
                _buildEditableField(
                  'Telefone',
                  _telefoneController,
                  Icons.phone,
                  TextInputType.phone,
                ),
                _buildEditableField(
                  'Endereço',
                  _enderecoController,
                  Icons.location_on,
                ),
                _buildEditableField(
                  'Área de Atuação',
                  _areaAtuacaoController,
                  Icons.work,
                ),
                _buildEditableField(
                  'Descrição',
                  _descricaoController,
                  Icons.description,
                  null,
                  3,
                ),
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

            // Documentos e Certificações
            _buildInfoCard(
              title: 'DOCUMENTOS E CERTIFICAÇÕES',
              children: [
                ListTile(
                  leading: Icon(Icons.description, color: AppColors.button),
                  title: const Text('Documentos Cadastrados'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: _verDocumentos,
                ),
                ListTile(
                  leading: Icon(Icons.verified, color: AppColors.button),
                  title: const Text('Certificações'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: _verCertificacoes,
                ),
                ListTile(
                  leading: Icon(Icons.add_circle, color: AppColors.button),
                  title: const Text('Adicionar Documento'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: _adicionarDocumento,
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
                    MaterialPageRoute(builder: (context) => const ConfiguracoesInstituicaoPage()),
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
  Widget _buildInfoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(
    String label,
    TextEditingController controller,
    IconData icon, [
    TextInputType? keyboardType,
    int maxLines = 1,
  ]) {
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
        maxLines: maxLines,
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
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePageInstituicao()));
        } else if (index == 2) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AjudaInstituicaoPage()));
        }
      },
    );
  }

  void _trocarLogo() {
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
      cnpj = _cnpjController.text;
      email = _emailController.text;
      telefone = _telefoneController.text;
      endereco = _enderecoController.text;
      areaAtuacao = _areaAtuacaoController.text;
      descricao = _descricaoController.text;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Alterações salvas com sucesso!')),
    );
  }

  void _verDocumentos() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Documentos Cadastrados')),
        body: const Center(child: Text('Lista de documentos da instituição')),
      ),
      ),
    );
  }

  void _verCertificacoes() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Certificações')),
        body: const Center(child: Text('Lista de certificações da instituição')),
      ),
      ),
    );
  }

  void _adicionarDocumento() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text('Tirar Foto do Documento'),
            onTap: () {
              Navigator.pop(context);
              // Implementar câmera para documentos
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Escolher da Galeria'),
            onTap: () {
              Navigator.pop(context);
              // Implementar seleção de arquivos
            },
          ),
          ListTile(
            leading: const Icon(Icons.cloud_upload),
            title: const Text('Upload de Arquivo'),
            onTap: () {
              Navigator.pop(context);
              // Implementar upload de arquivo
            },
          ),
        ],
      ),
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

  ListTile _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.button),
      title: Text(title),
      onTap: onTap,
    );
  }
