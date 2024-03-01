import 'package:flutter/material.dart';

import '../widgets/version_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Home Page"),
          ),
          body: const Center(
            child: Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 10,
                right: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Text('Your app is up to date!'),
                  Spacer(),
                  VersionWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
