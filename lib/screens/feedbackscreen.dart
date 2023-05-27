import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/index.dart';
import '../constants/index.dart';
import '../neopop/widgets/buttons/neopop_button/neopop_button.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final Email email = Email(
          subject: _titleController.text,
          body: _descriptionController.text,
          recipients: [FEEDBACK_EMAIL],
          isHTML: false);
      await FlutterEmailSender.send(email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).feedbackForm),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).title,
                    labelStyle: Theme.of(context).textTheme.bodyMedium,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context).pleasenteratitle;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).description,
                    labelStyle: Theme.of(context).textTheme.bodyMedium,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 10) {
                      return AppLocalizations.of(context)
                          .pleaseenteradescriptionofatleastencharacterslong;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 32, bottom: 40),
        child: SizedBox(
          width: Sizes.screenWidth(context),
          height: Sizes.screenHeight(context) * 0.05,
          child: NeoPopButton(
            onTapDown: () async {},
            bottomShadowColor: Theme.of(context).secondaryHeaderColor,
            rightShadowColor: Theme.of(context).secondaryHeaderColor,
            animationDuration: const Duration(milliseconds: 300),
            depth: 5,
            onTapUp: () {
              _submitForm();
            },
            color: Theme.of(context).canvasColor,
            shadowColor: Theme.of(context).secondaryHeaderColor,
            child: CustomText(
              style: Theme.of(context).textTheme.labelLarge,
              text: AppLocalizations.of(context).send,
            ),
          ),
        ),
      ),
    );
  }
}
