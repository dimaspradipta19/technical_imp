import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_imp/utils/result_state.dart';
import 'package:technical_imp/view/update_faq_screen.dart';
import 'package:technical_imp/viewmodel/provider/delete_faq_provider.dart';
import 'package:technical_imp/viewmodel/provider/detail_faq_provider.dart';

class DetailFaqScreen extends StatefulWidget {
  const DetailFaqScreen({super.key, required this.idFaq, required this.token});

  final int idFaq;
  final String token;

  @override
  State<DetailFaqScreen> createState() => _DetailFaqScreenState();
}

class _DetailFaqScreenState extends State<DetailFaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DetailFaq ${widget.idFaq}"), actions: [
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Are you sure want to delete the faq?'),
                    content: const Text('You need to create a new one'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Provider.of<DeleteFaqProvider>(context,
                                listen: false)
                            .deleteFaq(widget.token, widget.idFaq, context),
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.delete_forever))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return UpdateFaqScreen(
                idFaq: widget.idFaq,
              );
            },
          ));
        },
        child: const Icon(Icons.edit_note),
      ),
      body: Consumer<DetailFaqProvider>(
          builder: (context, valueDetailFaq, child) {
        if (valueDetailFaq.state == ResultState.loading) {
          return const CircularProgressIndicator.adaptive();
        } else if (valueDetailFaq.state == ResultState.error) {
          return const Text("Error");
        } else if (valueDetailFaq.state == ResultState.hasData) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(20)),
                    // height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Pertanyaan: "),
                          const SizedBox(height: 20.0),
                          Text(
                              "'${valueDetailFaq.detailFaqModel!.data.pertanyaan}'"),
                        ],
                      ),
                    )),
                const SizedBox(height: 20),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(20)),
                    // height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Jawaban: "),
                          const SizedBox(height: 20.0),
                          Text(
                              "'${valueDetailFaq.detailFaqModel!.data.jawaban}'"),
                        ],
                      ),
                    )),
              ],
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
