import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technical_imp/viewmodel/provider/create_faq_provider.dart';

class CreateFaqScreen extends StatefulWidget {
  const CreateFaqScreen({super.key});

  @override
  State<CreateFaqScreen> createState() => _CreateFaqScreenState();
}

class _CreateFaqScreenState extends State<CreateFaqScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _pertanyaan = TextEditingController();
  final TextEditingController _jawaban = TextEditingController();
  bool status = false;

  @override
  void dispose() {
    super.dispose();
    _pertanyaan.dispose();
    _jawaban.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Faq"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: FormBuilderTextField(
                      name: "Pertanyaan",
                      controller: _pertanyaan,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: FormBuilderTextField(
                      name: "Jawaban",
                      controller: _jawaban,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  FormBuilderSwitch(
                    name: "status_publish",
                    title: const Text("Status Publish"),
                    initialValue: status,
                    onChanged: (valueStatus) => setState(() {
                      status = valueStatus!;
                    }),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        String token = prefs.getString("token") ?? "";

                        Provider.of<CreateFaqProvider>(context, listen: false)
                            .postCreateFaq(_pertanyaan.text, _jawaban.text,
                                status, token, context);
                      },
                      child: const Text("Save"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
