import 'package:flutter/material.dart';

class InstagramMessageBar extends StatefulWidget {
  final ValueChanged<String> onSendMessage;

  const InstagramMessageBar({super.key, required this.onSendMessage});

  @override
  // ignore: library_private_types_in_public_api
  _InstagramMessageBarState createState() => _InstagramMessageBarState();
}

class _InstagramMessageBarState extends State<InstagramMessageBar> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isSending = false;

  void _handleSendMessage() async {
    if (_textEditingController.text.isNotEmpty && !_isSending) {
      setState(() {
        _isSending = true;
      });

      // Simulate sending message with delay

      // Invoke the onSendMessage callback
      widget.onSendMessage(_textEditingController.text);

      setState(() {
        _textEditingController.clear();
        _isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Travel to London!',
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                filled: true,
                fillColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          GestureDetector(
            onTap: _handleSendMessage,
            child: _isSending
                ? const CircularProgressIndicator(
                    strokeWidth: 2.0,
                  )
                : Icon(
                    Icons.send,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
          ),
        ],
      ),
    );
  }
}
