import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _tipoLogradouroController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _numeroController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();
  final _telefone1Controller = TextEditingController();
  final _telefone2Controller = TextEditingController();
  final _emailController = TextEditingController();
  String? _errorMessage;
  bool _obscureSenha = true;
  bool _isCNPJ = false;
  String _nomeLabel = 'Nome completo';

  int _currentStep = 0;
  bool _redirected = false;

  double get _progress {
    // Ajuste para 10 etapas (campos principais)
    return (_currentStep / 9).clamp(0.0, 1.0);
  }

  Future<void> _cadastrar() async {
    if (_formKey.currentState!.validate()) {
      String cpfCnpj = _cpfCnpjController.text;
      if (!CPFValidator.isValid(cpfCnpj) && !CNPJValidator.isValid(cpfCnpj)) {
        setState(() {
          _errorMessage = "CPF ou CNPJ inválido!";
        });
        return;
      }
      if (_isCNPJ) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePageInstituicao()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePageCpf()),
        );
      }
    }
  }

  Future<void> _buscarEnderecoPorCep(String cep) async {
    if (cep.length == 8) {
      final response = await http.get(
        Uri.parse('https://viacep.com.br/ws/$cep/json/'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['erro'] == null) {
          setState(() {
            _tipoLogradouroController.text = data['logradouro'] ?? '';
            _bairroController.text = data['bairro'] ?? '';
            _cidadeController.text = data['localidade'] ?? '';
            _estadoController.text = data['uf'] ?? '';
          });
        } else {
          // CEP não encontrado
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('CEP não encontrado')),
          );
        }
      } else {
        // Erro na requisição
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao buscar CEP')),
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
                color: _currentStep >= stepNumber
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

  void _handleCpfCnpjChange(String value) {
    bool isCnpjValid = CNPJValidator.isValid(value) && value.length == 14;
    bool isCpfValid = CPFValidator.isValid(value) && value.length == 11;

    setState(() {
      _isCNPJ = isCnpjValid;
      _nomeLabel = _isCNPJ ? 'Nome da Instituição' : 'Nome completo';
      _currentStep = 1;
      if (!isCnpjValid && !isCpfValid) {
        _redirected = false; // Permite novo redirecionamento se o campo for alterado
      }
    });

    // Redirecionamento fora do setState
    if (isCnpjValid && !_redirected) {
      _redirected = true;
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePageInstituicao()),
        );
      });
    } else if (isCpfValid && !_redirected) {
      _redirected = true;
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePageCpf()),
        );
      });
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
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                      bool isCnpjValid =
                          CNPJValidator.isValid(value) && value.length == 14;
                      _isCNPJ = isCnpjValid;
                      _nomeLabel =
                          _isCNPJ ? 'Nome da Instituição' : 'Nome completo';
                      _currentStep = 1;
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildStepIndicator(1, 'Informações Pessoais'),
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: _nomeLabel,
                    hintText: _isCNPJ
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
                  onChanged: (value) {
                    setState(() {
                      _currentStep = 2;
                    });
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
                  onChanged: (value) {
                    setState(() {
                      _currentStep = 3;
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildStepIndicator(2, 'Endereço'),
                TextFormField(
                  controller: _cepController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () async {
                        if (_cepController.text.length == 8) {
                          await _buscarEnderecoPorCep(_cepController.text);
                        }
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu CEP';
                    }
                    if (value.length != 8) {
                      return 'CEP deve ter 8 dígitos';
                    }
                    return null;
                  },
                  onChanged: (value) async {
                    setState(() {
                      _currentStep = 4;
                    });
                    if (value.length == 8) {
                      await _buscarEnderecoPorCep(value);
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _tipoLogradouroController,
                  decoration: InputDecoration(
                    labelText: 'Logradouro',
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
                      return 'Por favor, insira o logradouro';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _currentStep = 5;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _enderecoController,
                  decoration: InputDecoration(
                    labelText: 'Endereço',
                    hintText: 'Nome do logradouro',
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
                      return 'Por favor, insira o endereço';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _currentStep = 6;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _numeroController,
                  keyboardType: TextInputType.number,
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
                  onChanged: (value) {
                    setState(() {
                      _currentStep = 7;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _bairroController,
                  decoration: InputDecoration(
                    labelText: 'Bairro',
                    hintText: 'Digite seu bairro',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(Icons.location_city),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu bairro';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _currentStep = 8;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: _cidadeController,
                        decoration: InputDecoration(
                          labelText: 'Cidade',
                          hintText: 'Digite sua cidade',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          prefixIcon: const Icon(Icons.location_city),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira sua cidade';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _estadoController,
                        decoration: InputDecoration(
                          labelText: 'UF',
                          hintText: 'UF',
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
                            return 'Por favor, insira seu estado';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildStepIndicator(3, 'Contato'),
                TextFormField(
                  controller: _telefone1Controller,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                  onChanged: (value) {
                    setState(() {
                      _currentStep = 9;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _telefone2Controller,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                  keyboardType: TextInputType.emailAddress,
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
    _tipoLogradouroController.dispose();
    _enderecoController.dispose();
    _numeroController.dispose();
    _bairroController.dispose();
    _cidadeController.dispose();
    _estadoController.dispose();
    _telefone1Controller.dispose();
    _telefone2Controller.dispose();
    _emailController.dispose();
    super.dispose();
  }
}