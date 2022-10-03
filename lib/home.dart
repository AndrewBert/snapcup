import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController snapController = TextEditingController();
    final snapCubit = context.read<SnapCubit>();
    return BlocBuilder<SnapCubit, SnapState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 205, 77, 119),
          body: Row(
            children: [
              Expanded(
                flex: 7,
                child: Card(
                  color: const Color.fromARGB(200, 255, 255, 255),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                            child: SizedBox(
                              width: 100,
                              child: TextField(
                                controller: snapController,
                                maxLines: 3,
                              ),
                            ),
                          ),
                          GestureDetector(
                              child: SizedBox(
                                height: 600,
                                width: 600,
                                child: Text('this is the drawing zone'),
                              ),
                              onPanStart: (details) {
                                snapCubit.addDrawingPoints(
                                    globalPosition: details.globalPosition,
                                    context: context);
                              }
                              // onPanEnd: ,
                              ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Card(
                  color: Color.fromARGB(25, 255, 2555, 255),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'S N A P C U P',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      TextButton.icon(
                        label: const Text("Undo"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple),
                        ),
                        icon: const Icon(Icons.undo),
                        onPressed: () => {snapCubit.undo},
                      ),
                      // TextButton.icon(
                      //   label: const Text("Erase"),
                      //   icon: const Icon(Icons.undo),
                      //   onPressed: null,
                      // ),
                      // const SizedBox(
                      //   width: 10,
                      // ),
                      TextButton.icon(
                        label: const Text("Clear"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple),
                        ),
                        icon: const Icon(Icons.clear),
                        onPressed: () => {snapCubit.clear()},
                      ),
                      TextButton.icon(
                        label: const Text("Select Color"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple),
                        ),
                        icon: const Icon(Icons.color_lens),
                        onPressed: null,
                      ),
                      TextButton(
                        child: const Text("Place snap in snapcup!"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple),
                        ),
                        onPressed: () async => {await snapCubit.submitSnap()},
                      ),
                      Card(
                        color: Colors.red,
                        child: Text(
                            'snap cup image goes here \n \n \n snap count: x \n \n \n'),
                      ),
                      TextButton(
                        child: const Text("Read a snap"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple),
                        ),
                        onPressed: () async => {await snapCubit.pickSnap()},
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
