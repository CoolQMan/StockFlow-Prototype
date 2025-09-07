import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/sample_inventory_database.dart';

class GeminiAnalyticsService {
  // TODO: Replace with your actual Gemini API key from Google AI Studio
  // Get your API key at: https://makersuite.google.com/app/apikey
  static const String _apiKey =
      'YOUR_API_KEY'; // Replace with your actual API key

  late final GenerativeModel _model;
  late final ChatSession _chat;

  GeminiAnalyticsService() {
    print('Initializing Gemini Analytics Service...');
    print('API Key length: ${_apiKey.length}');
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: _apiKey,
      systemInstruction: Content.system('''
You are an AI analytics assistant for inventory management. You have access to the following inventory database:

${SampleInventoryDatabase.getFormattedDatabase()}

INSTRUCTIONS:
1. ONLY answer questions related to the inventory data provided above
2. If asked about anything else (weather, news, general knowledge, etc.), politely decline and redirect to inventory topics
3. Always provide specific, actionable insights based on the data
4. Format your responses clearly with bullet points, numbers, and structured information
5. When presenting tabular data, use markdown table format
6. Include relevant metrics like blocked cash amounts, sell-through rates, and turnover rates
7. Suggest actionable recommendations when appropriate
8. Be concise but informative
9. Keep the answer relevant to inventory management only
10. Make sure the answer is short and concise and to the point with good structure and formatting
11. Output the data in a way that it seems like that the data is coming from a database and not from an AI model

VALID TOPICS:
- Product information and analysis
- Category performance
- Warehouse utilization
- Aging inventory analysis
- Cash flow optimization
- Sell-through and turnover rates
- Stock levels and recommendations

INVALID TOPICS:
- Weather, news, sports, entertainment
- General knowledge questions
- Personal advice
- Anything not related to inventory management
'''),
    );

    _chat = _model.startChat();
    print('Gemini Analytics Service initialized successfully');
  }

  Future<String> analyzeQuery(String userQuery) async {
    try {
      final response = await _chat.sendMessage(Content.text(userQuery));
      return response.text ??
          'I apologize, but I couldn\'t generate a response. Please try rephrasing your question.';
    } catch (e) {
      // Log the actual error for debugging
      print('Gemini API Error: $e');
      print('Error type: ${e.runtimeType}');
      return 'I\'m sorry, but I encountered an error while analyzing your query. Please make sure your question is related to inventory management and try again.';
    }
  }

  // Method to test API connectivity
  Future<String> testConnection() async {
    try {
      final response = await _chat.sendMessage(
        Content.text(
          'Hello, can you respond with just "API working" if you receive this?',
        ),
      );
      return response.text ?? 'No response received';
    } catch (e) {
      print('API Test Error: $e');
      return 'API Error: $e';
    }
  }
}
