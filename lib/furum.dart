import 'package:flutter/material.dart';
import '../../theme.dart';
import 'sessions/cpf/forumcpf.dart';
class ForumPreview extends StatelessWidget {
  const ForumPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            const Text(
              'FÓRUM DA COMUNIDADE',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Participe das discussões e interaja com outros membros da comunidade:',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.secondaryText,
              ),
            ),
            const SizedBox(height: 16),
            
            // Tópico em destaque
            _buildForumTopic(
              title: 'Como ajudar pessoas em situação de rua?',
              author: 'Maria Silva',
              replies: 24,
            ),
            const SizedBox(height: 12),
            
            _buildForumTopic(
              title: 'Doações de alimentos - Melhores práticas',
              author: 'João Oliveira',
              replies: 15,
            ),
            const SizedBox(height: 16),
            
            // Botão para acessar o fórum completo
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navegar para a tela completa do fórum
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ForumPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.button,
                  foregroundColor: AppColors.buttonText,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Acessar o Fórum Completo',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForumTopic({
    required String title,
    required String author,
    required int replies,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Por $author • $replies respostas',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}