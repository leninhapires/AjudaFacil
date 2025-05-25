import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importe o Provider
import 'cadastro.dart';
import 'login.dart';
import 'theme.dart';
import 'sessions/cpf/home.dart';
import 'sessions/cnpj/home.dart';
import 'package:dots_indicator/dots_indicator.dart';

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
          routes: {
            '/cadastro':
                (context) =>
                    CadastroScreen(), // Substitua CadastroScreen() pela sua tela de cadastro
          },
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
                  semanticHint:
                      'Toque para saber mais sobre o aplicativo e iniciar o cadastro',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AboutAppScreen()),
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

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  AboutAppScreenState createState() => AboutAppScreenState();
}

class AboutAppScreenState extends State<AboutAppScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<String> texts = [
    '''BEM-VINDO AO NOSSO APLICATIVO!
ESTE APP FOI CRIADO PARA CONECTAR PESSOAS, ONGS, IGREJAS E INSTITUIÇÕES QUE QUEREM AJUDAR E SEREM AJUDADAS.''',
    '''AQUI, ORGANIZAÇÕES PODEM SE CADASTRAR PARA RECEBER DOAÇÕES DE ITENS OU DINHEIRO, FACILITANDO O SUPORTE A QUEM REALMENTE PRECISA.
SE VOCÊ É UMA PESSOA QUE DESEJA FAZER A DIFERENÇA, TAMBÉM PODE SE CADASTRAR PARA ENCONTRAR ESSAS INSTITUIÇÕES E CONTRIBUIR COM DOAÇÕES, SEJA COM RECURSOS FINANCEIROS OU COM ITENS QUE VOCÊ QUER DOAR.''',
    '''NOSSO OBJETIVO É FORTALECER A REDE DE SOLIDARIEDADE, TORNANDO MAIS FÁCIL E ACESSÍVEL O ENCONTRO ENTRE QUEM AJUDA E QUEM PRECISA DE AJUDA. JUNTOS, PODEMOS TRANSFORMAR VIDAS!
AO PROSSEGUIR VOCE CONCORDA COM NOSSOS TERMOS.''',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/image/logo.png', // Caminho para sua logo
          height: 40, // Ajuste a altura conforme necessário
        ),
        centerTitle: true, // Opcional: centraliza a logo
      ),
      body: Container(
        // Centraliza todo o conteúdo
        color: AppColors.background,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: texts.length,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Center(
                        child: Container(
                          height: 200, // Defina a altura desejada
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.button,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Text(
                            texts[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.buttonText,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                DotsIndicator(
                  dotsCount: texts.length,
                  position: _currentPage.toDouble(),
                  decorator: DotsDecorator(
                    color: Colors.grey, // Cor das bolinhas não selecionadas
                    activeColor: AppColors.button, // Cor da bolinha selecionada
                  ),
                ),
                _currentPage < texts.length - 1
                    ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.button,
                        foregroundColor: AppColors.buttonText,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      child: const Text('Próximo'),
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                    )
                    : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.button,
                        foregroundColor: AppColors.buttonText,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      child: const Text('Acessar Cadastro'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CadastroScreen(),
                          ),
                        );
                      },
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
