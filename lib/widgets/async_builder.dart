import 'package:flutter/material.dart';

class AsyncBuilder<T> extends StatelessWidget {
  final Future<T>? future;
  final Function(BuildContext, T) builder;

  const AsyncBuilder({super.key, required this.future, required this.builder});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
        future: future,
        builder: (context, snapshot) {
          List<Widget> children;
          if (snapshot.hasError) {
            print('Error: ${snapshot.error}\nStack: ${(snapshot.error as Error).stackTrace}');
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${(snapshot.error as Error).stackTrace}'),
              ),
            ];
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('En attente de resultat...'),
              ),
            ];
          } else {
            return builder(context, snapshot.data as T);
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        });
  }
}
