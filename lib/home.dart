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
                child: Center(
                  child: Card(
                    color: Colors.white,
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
                                child: Text('this is the drawing zone'),
                              ),
                              // onPanStart:,
                              // onPanEnd: ,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            label: const Text("Undo"),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.pink),
                            ),
                            icon: const Icon(Icons.undo),
                            onPressed: () => {snapCubit.undo},
                          ),
                          const SizedBox(
                            width: 10,
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
                            icon: const Icon(Icons.clear),
                            onPressed: () => {snapCubit.clear()},
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton.icon(
                            label: const Text("Select Color"),
                            icon: const Icon(Icons.clear),
                            onPressed: null,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            child: const Text("Place snap in snapcup!"),
                            onPressed: () async =>
                                {await snapCubit.submitSnap()},
                          )
                        ],
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
