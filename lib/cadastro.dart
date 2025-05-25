import 'package:flutter/material.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'theme.dart';
import 'sessions/cpf/home.dart';
import 'sessions/cnpj/home.dart';

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
  bool _isCNPJ = false;
  String _nomeLabel = 'Nome completo'; // Valor inicial do label

  int _currentStep = 0;

  double get _progress {
    switch (_currentStep) {
      case 0:
        return 0.2;
      case 1:
        return 0.4;
      case 2:
        return 0.6;
      case 3:
        return 0.8;
      default:
        return 0.0;
    }
  }

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

      if (!CPFValidator.isValid(cpfCnpj) && !CNPJValidator.isValid(cpfCnpj)) {
        setState(() {
          _errorMessage = "CPF ou CNPJ inválido!";
        });
        return;
      }

      print('Cadastro bem-sucedido!');
      if (_isCNPJ) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePageCnpj()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePageCpf()),
        );
      }
    }
  }

  Widget _buildStepIndicator(int stepNumber, String title) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color:
                    _currentStep >= stepNumber
                        ? AppColors.button
                        : Colors.grey[400],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  (stepNumber + 1).toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset('assets/image/logo.png', height: 100),
                const SizedBox(height: 24),
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
                LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.button),
                ),
                const SizedBox(height: 12),
                Text(
                  "Comece a usar o Ajuda Fácil agora mesmo!",
                  style: TextStyle(fontSize: 16, color: AppColors.button),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
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
                _buildStepIndicator(0, 'Documento'),
                TextFormField(
                  controller: _cpfCnpjController,
                  decoration: InputDecoration(
                    labelText: 'CPF ou CNPJ',
                    hintText: 'Digite seu CPF ou CNPJ',
                    border: OutlineInputBorder(
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
                  onChanged: (value) {
                    setState(() {
                      // Se for CNPJ válido e 14 dígitos, muda label e redireciona
                      if (CNPJValidator.isValid(value) && value.length == 14) {
                        _isCNPJ = true;
                        _nomeLabel = 'Nome da Instituição';
                        // Redireciona para HomePageCnpj
                        Future.microtask(() {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomePageCnpj(),
                            ),
                          );
                        });
                      } else {
                        // Mantém como CPF
                        _isCNPJ = false;
                        _nomeLabel = 'Nome completo';
                        // Redireciona para HomePageCpf se for CPF válido e 11 dígitos
                        if (CPFValidator.isValid(value) && value.length == 11) {
                          Future.microtask(() {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomePageCpf(),
                              ),
                            );
                          });
                        }
                      }
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildStepIndicator(1, 'Informações Pessoais'),
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: _nomeLabel, // Usa o label atualizado
                    hintText:
                        _isCNPJ
                            ? 'Digite o nome da instituição'
                            : 'Digite seu nome completo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _senhaController,
                  obscureText: _obscureSenha,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    hintText: 'Crie uma senha segura',
                    border: OutlineInputBorder(
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
                _buildStepIndicator(2, 'Endereço'),
                TextFormField(
                  controller: _cepController,
                  decoration: InputDecoration(
                    labelText: 'CEP',
                    hintText: 'Digite seu CEP',
                    border: OutlineInputBorder(
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
                TextFormField(
                  controller: _ruaController,
                  decoration: InputDecoration(
                    labelText: 'Rua',
                    hintText: 'Digite sua rua',
                    border: OutlineInputBorder(
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
                TextFormField(
                  controller: _tipoLogradouroController,
                  decoration: InputDecoration(
                    labelText: 'Tipo de Logradouro',
                    hintText: 'Ex: Rua, Avenida, Travessa',
                    border: OutlineInputBorder(
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
                TextFormField(
                  controller: _numeroController,
                  decoration: InputDecoration(
                    labelText: 'Número',
                    hintText: 'Digite o número',
                    border: OutlineInputBorder(
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
                _buildStepIndicator(3, 'Contato'),
                TextFormField(
                  controller: _telefone1Controller,
                  decoration: InputDecoration(
                    labelText: 'Telefone 1',
                    hintText: 'Digite seu telefone principal',
                    border: OutlineInputBorder(
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
                TextFormField(
                  controller: _telefone2Controller,
                  decoration: InputDecoration(
                    labelText: 'Telefone 2 (opcional)',
                    hintText: 'Digite seu telefone secundário',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(Icons.phone),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Digite seu email',
                    border: OutlineInputBorder(
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
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/image/glogo.png',
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(width: 8),
                      const Text('Autenticação Google'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _cadastrar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: AppColors.buttonText,
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
