import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technical_imp/utils/result_state.dart';
import 'package:technical_imp/view/create_faq_screen.dart';
import 'package:technical_imp/viewmodel/provider/auth_provider.dart';
import 'package:technical_imp/viewmodel/provider/detail_faq_provider.dart';
import 'package:technical_imp/viewmodel/provider/list_faq_provider.dart';
import 'package:technical_imp/viewmodel/service/list_faq_service.dart';

import 'detail_faq_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String token = '';

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token') ?? '';
    });

    Provider.of<ListFaqProvider>(context, listen: false).getListFaq(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homescreen FAQ"),
        actions: [
          Consumer<AuthProvider>(
            builder: (context, valueLogout, child) => IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Are you sure want to quit the app?'),
                        content: const Text('You need to login again'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Provider.of<AuthProvider>(context,
                                    listen: false)
                                .postLogout(
                                    valueLogout.loginModel!.data.accessToken,
                                    context),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.logout_outlined)),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateFaqScreen(),
                ));
          },
          child: const Icon(Icons.edit)),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<ListFaqProvider>(context, listen: false)
            .getListFaq(token),
        child:
            /* if using consumer for fetching data on homescreen */
            Consumer<ListFaqProvider>(
          builder: (context, valueList, child) {
            if (valueList.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (valueList.state == ResultState.error) {
              return const Text("Error");
            } else if (valueList.state == ResultState.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: valueList.listFaq!.data.length,
                      itemBuilder: (context, index) {
                        return GFAccordion(
                          collapsedTitleBackgroundColor: Colors.grey[200]!,
                          contentBackgroundColor: Colors.grey[100],
                          expandedTitleBackgroundColor: Colors.grey[200]!,
                          titlePadding: const EdgeInsets.all(10.0),
                          contentPadding: const EdgeInsets.all(10.0),
                          titleChild: Text(
                              "${index + 1} ${valueList.listFaq!.data[index].pertanyaan}"),
                          contentChild: InkWell(
                              onTap: () => Provider.of<DetailFaqProvider>(
                                      context,
                                      listen: false)
                                  .getDetailFaq(
                                    token,
                                    valueList.listFaq!.data[index].id,
                                    context,
                                  )
                                  .then((value) =>
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return DetailFaqScreen(
                                            idFaq: valueList
                                                .listFaq!.data[index].id,
                                            token: token,
                                          );
                                        },
                                      ))),
                              child:
                                  Text(valueList.listFaq!.data[index].jawaban)),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
