import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final TextEditingController promptController;
  String responseTxt = '';

  @override
  void initState() {
    promptController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff343541),
      appBar: AppBar(
        title: const Text(
          'Flutter and ChatGPT',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff343541),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PromptBldr(responseTxt: responseTxt),
          TextFormFieldBldr(
            promptController: promptController,
            btnFun: completionFun,
          ),
        ],
      ),
    );
  }

  completionFun() async {
    setState(() => responseTxt = 'Loading...');
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${dotenv.env['token']}'
      },
      body: jsonEncode(
        {
          "model": "text-davinci-003",
          "prompt": promptController.text,
          "max_tokens": 250,
          "temperature": 0,
          "top_p": 1,
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        responseTxt = data['choices'][0]['text'];
      });
    } else {
      setState(() {
        responseTxt = 'Error: ${response.reasonPhrase}';
      });
    }
  }
}

class PromptBldr extends StatelessWidget {
  const PromptBldr({
    super.key,
    required this.responseTxt,
  });

  final String responseTxt;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.35,
      color: const Color(0xff434654),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Text(
              responseTxt,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFormFieldBldr extends StatelessWidget {
  const TextFormFieldBldr({
    super.key,
    required this.promptController,
    required this.btnFun,
  });

  final TextEditingController promptController;
  final Function btnFun;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff434654),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: promptController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Enter your prompt...',
                  hintStyle: TextStyle(color: Colors.white70),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () => btnFun(),
            ),
          ],
        ),
      ),
    );
  }
  
}
