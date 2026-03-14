import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  Stream<String> getLloadingMessages() {
    final messages = <String>[
      "Loading.",
      "Loading..",
      "Loading...",
      "Loading....",
      "Loading.....",
    ];
    return Stream.periodic(
      Duration(milliseconds: 200),
      (step) => messages[step % messages.length] ,
    );
  }

  const FullScreenLoader({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Please Wait"),
        SizedBox(
          height: 10,
        ),
        CircularProgressIndicator(
          strokeWidth: 2,
        ),
        SizedBox(
          height: 10,
        ),
        StreamBuilder(
          stream: getLloadingMessages(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text("Cargando");
            }
            return Text(snapshot.data!);
          },
        )
      ],
    ));
  }
}
