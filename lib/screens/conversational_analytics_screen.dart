import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../services/gemini_analytics_service.dart';

class ConversationalAnalyticsScreen extends StatefulWidget {
  const ConversationalAnalyticsScreen({super.key});

  @override
  State<ConversationalAnalyticsScreen> createState() =>
      _ConversationalAnalyticsScreenState();
}

class _ConversationalAnalyticsScreenState
    extends State<ConversationalAnalyticsScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [
    {
      'text':
          'Hello! I\'m your AI inventory analytics assistant. I can help you analyze your inventory data, identify trends, and provide insights on cash flow optimization. What would you like to know?',
      'isUser': false,
      'timestamp': DateTime.now(),
    },
  ];
  final List<String> _quickQuestions = [
    'Show items with zero sales in 120 days',
    'Analyze aging inventory by categories',
    'Top categories by blocked cash',
    'Warehouse utilization analysis',
  ];

  late final GeminiAnalyticsService _geminiService;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _geminiService = GeminiAnalyticsService();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage([String? quickQuestion]) async {
    final message = quickQuestion ?? _controller.text.trim();
    if (message.isEmpty) return;

    setState(() {
      _messages.add({
        'text': message,
        'isUser': true,
        'timestamp': DateTime.now(),
      });
      _isLoading = true;
    });

    _controller.clear();
    _scrollToBottom();

    try {
      final response = await _geminiService.analyzeQuery(message);

      setState(() {
        _messages.add({
          'text': response,
          'isUser': false,
          'timestamp': DateTime.now(),
        });
        _isLoading = false;
      });
      _scrollToBottom();
    } catch (e) {
      setState(() {
        _messages.add({
          'text':
              'Sorry, I encountered an error. Please make sure your Gemini API key is configured correctly and try again.',
          'isUser': false,
          'timestamp': DateTime.now(),
        });
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  Future<void> _handleQuickQuestion(String question) async {
    await _sendMessage(question);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversational Analytics'),
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Analytics Assistant',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ask questions about your inventory performance',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),

            // Messages
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _messages.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _messages.length && _isLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final message = _messages[index];
                  final isUser = message['isUser'] as bool;

                  return TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, double value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(
                            isUser ? 20 * (1 - value) : -20 * (1 - value),
                            0,
                          ),
                          child: child,
                        ),
                      );
                    },
                    child: Align(
                      alignment: isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(16),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        decoration: BoxDecoration(
                          color: isUser
                              ? theme.colorScheme.primary
                              : theme.colorScheme.surface,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: isUser
                                ? const Radius.circular(16)
                                : const Radius.circular(4),
                            bottomRight: isUser
                                ? const Radius.circular(4)
                                : const Radius.circular(16),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.shadow.withValues(
                                alpha: 0.1,
                              ),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: isUser
                            ? Text(
                                message['text'] as String,
                                style: TextStyle(
                                  color: theme.colorScheme.onPrimary,
                                ),
                              )
                            : MarkdownBody(
                                data: message['text'] as String,
                                styleSheet: MarkdownStyleSheet.fromTheme(theme)
                                    .copyWith(
                                      p: theme.textTheme.bodyMedium?.copyWith(
                                        color: theme.colorScheme.onSurface,
                                      ),
                                      tableHead: theme.textTheme.titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      tableBorder: TableBorder.all(
                                        color: theme.colorScheme.outline
                                            .withOpacity(0.3),
                                        width: 1,
                                      ),
                                      tableBody: theme.textTheme.bodySmall,
                                      tableHeadAlign: TextAlign.center,
                                    ),
                              ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Quick questions
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              color: theme.colorScheme.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Questions',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) => ActionChip(
                        label: Text(
                          _quickQuestions[i],
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        backgroundColor:
                            theme.colorScheme.surfaceContainerHighest,
                        onPressed: () =>
                            _handleQuickQuestion(_quickQuestions[i]),
                      ),
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemCount: _quickQuestions.length,
                    ),
                  ),
                ],
              ),
            ),

            // Input area
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: theme.colorScheme.outline.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Ask about your inventory...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: theme.colorScheme.surfaceContainerHighest,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  FloatingActionButton(
                    onPressed: _isLoading ? null : () => _sendMessage(),
                    mini: true,
                    backgroundColor: _isLoading
                        ? theme.colorScheme.surfaceContainerHighest
                        : theme.colorScheme.primary,
                    foregroundColor: _isLoading
                        ? theme.colorScheme.onSurface.withValues(alpha: 0.5)
                        : theme.colorScheme.onPrimary,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
