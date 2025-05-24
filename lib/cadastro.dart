import 'package:flutter/material.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'theme.dart'; // Importe seu arquivo de tema

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({Key? key}) : super(key: key);

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfCnpjController = TextEditingController();
  final _senhaController = TextEditingController();
  final _cepController = TextEditingController();
  final _ruaController = TextEditingController();
  final _tipoLogradouroController = TextEditingController();
  final _numeroController = TextEditingController();
  final _telefone1Controller = TextEditingController();
  final _telefone2Controller = TextEditingController();
  final _emailController = TextEditingController();
  String? _errorMessage;
  bool _obscureSenha = true;

  Future<void> _cadastrar() async {
    if (_formKey.currentState!.validate()) {
      String nome = _nomeController.text;
      String cpfCnpj = _cpfCnpjController.text;
      String senha = _senhaController.text;
      String cep = _cepController.text;
      String rua = _ruaController.text;
      String tipoLogradouro = _tipoLogradouroController.text;
      String numero = _numeroController.text;
      String telefone1 = _telefone1Controller.text;
      String telefone2 = _telefone2Controller.text;
      String email = _emailController.text;

      // Validação do CPF/CNPJ
      if (!CPFValidator.isValid(cpfCnpj) && !CNPJValidator.isValid(cpfCnpj)) {
        setState(() {
          _errorMessage = "CPF ou CNPJ inválido!";
        });
        return;
      }

      // TODO: Implementar a lógica de cadastro aqui
      // Você pode usar Firebase Authentication, um banco de dados local, etc.
      // Exemplo:
      // try {
      //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //     email: cpfCnpj, // Use CPF/CNPJ como email (se for o caso)
      //     password: senha,
      //   );
      //   // Cadastro bem-sucedido
      //   Navigator.pushReplacementNamed(context, '/home');
      // } catch (e) {
      //   setState(() {
      //     _errorMessage = "Erro ao cadastrar: $e";
      //   });
      // }

      // Simulação de cadastro bem-sucedido (sem Firebase)
      print('Cadastro bem-sucedido!');
      Navigator.pop(context); // Retorna para a tela anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Cadastro'),
        backgroundColor: AppColors.button,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo
                Image.asset('assets/image/logo.png', height: 100),
                const SizedBox(height: 24),

                // Título
                Text(
                  "Crie sua conta",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                // Subtítulo
                Text(
                  "Comece a usar o Ajuda Fácil agora mesmo!",
                  style: TextStyle(fontSize: 16, color: AppColors.button),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Mensagem de erro
                if (_errorMessage != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // Campo de nome
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome completo',
                    hintText: 'Digite seu nome completo',
                    border: OutlineInputBorder(
                      // Adiciona a borda
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu nome';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Campo de CPF/CNPJ
                TextFormField(
                  controller: _cpfCnpjController,
                  decoration: InputDecoration(
                    labelText: 'CPF ou CNPJ',
                    hintText: 'Digite seu CPF ou CNPJ',
                    border: OutlineInputBorder(
                      // Adiciona a borda
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(Icons.badge),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu CPF ou CNPJ';
                    }
                    if (!CPFValidator.isValid(value) &&
                        !CNPJValidator.isValid(value)) {
                      return 'CPF ou CNPJ inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Campo de senha
                TextFormField(
                  controller: _senhaController,
                  obscureText: _obscureSenha,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    hintText: 'Crie uma senha segura',
                    border: OutlineInputBorder(
                      // Adiciona a borda
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureSenha ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureSenha = !_obscureSenha;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, crie uma senha';
                    }
                    if (value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Campo de CEP
                TextFormField(
                  controller: _cepController,
                  decoration: InputDecoration(
                    labelText: 'CEP',
                    hintText: 'Digite seu CEP',
                    border: OutlineInputBorder(
                      // Adiciona a borda
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu CEP';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Campo de Rua
                TextFormField(
                  controller: _ruaController,
                  decoration: InputDecoration(
                    labelText: 'Rua',
                    hintText: 'Digite sua rua',
                    border: OutlineInputBorder(
                      // Adiciona a borda
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(Icons.home),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua rua';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Campo de Tipo de Logradouro
                TextFormField(
                  controller: _tipoLogradouroController,
                  decoration: InputDecoration(
                    labelText: 'Tipo de Logradouro',
                    hintText: 'Ex: Rua, Avenida, Travessa',
                    border: OutlineInputBorder(
                      // Adiciona a borda
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(Icons.map),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o tipo de logradouro';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Campo de Número
                TextFormField(
                  controller: _numeroController,
                  decoration: InputDecoration(
                    labelText: 'Número',
                    hintText: 'Digite o número',
                    border: OutlineInputBorder(
                      // Adiciona a borda
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(Icons.numbers),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o número';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Campo de Telefone 1
                TextFormField(
                  controller: _telefone1Controller,
                  decoration: InputDecoration(
                    labelText: 'Telefone 1',
                    hintText: 'Digite seu telefone principal',
                    border: OutlineInputBorder(
                      // Adiciona a borda
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu telefone principal';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Campo de Telefone 2
                TextFormField(
                  controller: _telefone2Controller,
                  decoration: InputDecoration(
                    labelText: 'Telefone 2 (opcional)',
                    hintText: 'Digite seu telefone secundário',
                    border: OutlineInputBorder(
                      // Adiciona a borda
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(Icons.phone),
                  ),
                ),
                const SizedBox(height: 16),

                // Campo de Email
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Digite seu email',
                    border: OutlineInputBorder(
                      // Adiciona a borda
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu email';
                    }
                    if (!value.contains('@')) {
                      return 'Por favor, insira um email válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: null, // Botão inativo
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.grey[400], // Cor cinza para indicar inatividade
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 70,
                      vertical: 16,
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Autenticação Google'),
                ),
                const SizedBox(height: 24),

                // Botão de cadastro
                ElevatedButton(
                  onPressed: _cadastrar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Cadastrar'),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfCnpjController.dispose();
    _senhaController.dispose();
    _cepController.dispose();
    _ruaController.dispose();
    _tipoLogradouroController.dispose();
    _numeroController.dispose();
    _telefone1Controller.dispose();
    _telefone2Controller.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
