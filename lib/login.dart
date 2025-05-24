import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importe o Provider
import 'cadastro.dart';
import 'login.dart';
import 'theme.dart';
import 'sessions/cpf/home.dart';
import 'sessions/cnpj/home.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:cpf_cnpj_validator/cnpj_validator.dart';

class AccessibilitySettings extends ChangeNotifier {
  double fontSize = 16.0;
  bool highContrast = false;
  bool isAccessibilityEnabled = false;

  void toggleAccessibility() {
    isAccessibilityEnabled = !isAccessibilityEnabled;
    notifyListeners();
  }

  void toggleHighContrast() {
    highContrast = !highContrast;
    notifyListeners();
  }

  void increaseFontSize() {
    fontSize += 2;
    notifyListeners();
  }

  void decreaseFontSize() {
    fontSize -= 2;
    if (fontSize < 10) {
      fontSize = 10;
    }
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      // Use o ChangeNotifierProvider
      create: (context) => AccessibilitySettings(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AccessibilitySettings>(
      // Use o Consumer
      builder: (context, settings, child) {
        return MaterialApp(
          title: 'Ajuda Fácil',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: TextTheme(
              bodyLarge: TextStyle(fontSize: settings.fontSize),
              bodyMedium: TextStyle(fontSize: settings.fontSize),
              titleLarge: TextStyle(fontSize: settings.fontSize + 4),
              titleMedium: TextStyle(fontSize: settings.fontSize + 2),
            ),
            colorScheme:
                settings.highContrast
                    ? const ColorScheme.highContrastLight()
                    : const ColorScheme.light(),
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startApp();
  }

  Future<void> _startApp() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Semantics(
        label: 'Tela de carregamento do Ajuda Fácil',
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Semantics(
                label: 'Aguarde, por favor...',
                child: const Text(
                  'Aguarde, por favor...',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Semantics(
                label: 'Logo do Ajuda Fácil',
                child: Image.asset(
                  'assets/image/logo.png',
                  width: 250,
                  height: 250,
                  fit: BoxFit.contain,
                  semanticLabel: 'Logo do Ajuda Fácil',
                ),
              ),
              const SizedBox(height: 30),
              Semantics(
                label: 'Estamos preparando tudo para você',
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.button,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Estamos preparando tudo para você.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          color: AppColors.buttonText,
                        ),
                      ),
                      SizedBox(height: 30),
                      CircularProgressIndicator(
                        color: Color.fromARGB(255, 195, 247, 225),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  void _openAccessibilityDialog(BuildContext context) {
    final accessibilitySettings = Provider.of<AccessibilitySettings>(
      context,
      listen: false,
    );

    showDialog(
      context: context,
      builder:
          (_) => Semantics(
            label: 'Configurações de acessibilidade',
            child: AlertDialog(
              title: const Text('Configurações de Acessibilidade'),
              content: Consumer<AccessibilitySettings>(
                builder: (context, settings, child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Modo Acessibilidade'),
                          Switch(
                            value: settings.isAccessibilityEnabled,
                            onChanged: (value) {
                              settings.toggleAccessibility();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Alto Contraste'),
                          Switch(
                            value: settings.highContrast,
                            onChanged: (value) {
                              settings.toggleHighContrast();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text('Tamanho da Fonte'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: settings.decreaseFontSize,
                          ),
                          Text('${settings.fontSize.toInt()}px'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: settings.increaseFontSize,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Fechar'),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildAccessibleButton({
    required String label,
    required String semanticHint,
    required VoidCallback onPressed,
  }) {
    return Semantics(
      button: true,
      label: label,
      hint: semanticHint,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 3,
              backgroundColor: AppColors.button,
              foregroundColor: AppColors.buttonText,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: onPressed,
            child: Text(label, style: const TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Semantics(
        button: true,
        label: 'Configurações de acessibilidade',
        hint: 'Toque para abrir as configurações de acessibilidade',
        child: FloatingActionButton(
          onPressed: () => _openAccessibilityDialog(context),
          child: const Icon(Icons.accessibility_new),
        ),
      ),
      body: Semantics(
        label: 'Tela inicial do Ajuda Fácil',
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Semantics(
                  header: true,
                  child: const Text(
                    'BEM-VINDO AO AJUDA FÁCIL',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                Semantics(
                  label: 'Logo do Ajuda Fácil',
                  image: true,
                  child: Image.asset(
                    'assets/image/logo.png',
                    width: 250,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),
                _buildAccessibleButton(
                  label: 'Já tenho acesso',
                  semanticHint: 'Toque para fazer login no aplicativo',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildAccessibleButton(
                  label: 'Iniciar Cadastro',
                  semanticHint: 'Toque para criar uma nova conta',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CadastroScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Semantics(
                  label: 'Direitos reservados',
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      '© 2025 Todos os direitos reservados - CloudVision',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cpfCnpjController = TextEditingController();
  String? _errorMessage;

  Future<void> _signInWithEmailAndPassword() async {
    String cpfCnpj = _cpfCnpjController.text;

    if (CPFValidator.isValid(cpfCnpj)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePageCpf()),
      );
    } else if (CNPJValidator.isValid(cpfCnpj)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePageCnpj()),
      );
    } else {
      setState(() {
        _errorMessage = "CPF ou CNPJ inválido!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/image/logo.png', height: 120),
              const SizedBox(height: 24),
              Text(
                "Bem-vindo de volta!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Faça login para continuar aproveitando o Ajuda Fácil.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText,
                ),
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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _cpfCnpjController,
                      decoration: InputDecoration(
                        labelText: 'CPF ou CNPJ',
                        hintText: 'Digite seu CPF ou CNPJ',
                        border: OutlineInputBorder(
                          // Adiciona a borda
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ), // Cor da borda
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        prefixIcon: const Icon(Icons.badge),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: null, // Botão inativo
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            AppColors
                                .button, // Cor cinza para indicar inatividade
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 70,
                          vertical: 24,
                        ),
                        textStyle: const TextStyle(fontSize: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text('Autenticação Google'),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _signInWithEmailAndPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.button,
                        foregroundColor: AppColors.buttonText,
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 90,
                        ),
                        textStyle: const TextStyle(fontSize: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text('Entrar'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Não tem uma conta?",
                    style: TextStyle(color: AppColors.button),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cadastro');
                    },
                    child: const Text(
                      "Cadastre-se",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cpfCnpjController.dispose();
    super.dispose();
  }
}

bool isValidCPF(String cpf) {
  return CPFValidator.isValid(cpf);
}

bool isValidCNPJ(String cnpj) {
  return CNPJValidator.isValid(cnpj);
}
