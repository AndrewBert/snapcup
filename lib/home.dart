import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapcup/models/drawing_painter.dart';
import 'package:snapcup/widgets/color_picker_dialog.dart';
import 'package:snapcup/styles/styles.dart';
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
          backgroundColor: Colors.white,
          body: Row(
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0xffff7da9),
                        child: TextField(
                          controller: snapController,
                          maxLines: 5,
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Snaps to Parahat for...",
                            hintStyle: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                          label: const Text(
                            "Undo",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            // shape: MaterialStateProperty.all<OutlinedBorder>()
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffff7da9)),
                          ),
                          icon: const Icon(
                            Icons.undo,
                            color: Colors.white,
                          ),
                          onPressed: () => {snapCubit.undo},
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        TextButton.icon(
                          label: const Text(
                            "Clear",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffff7da9)),
                          ),
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.white,
                          ),
                          onPressed: () => {snapCubit.clear()},
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        TextButton.icon(
                            label: const Text(
                              "Select Color",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xffff7da9)),
                            ),
                            icon: const Icon(
                              Icons.color_lens,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    return ColorPickerDialog(
                                        selectedColor: Colors.red,
                                        onColorChanged: (Color color) {
                                          snapCubit.changeColor(Colors.red);
                                          return color;
                                        });
                                  });
                            }),
                      ],
                    ),
                    GestureDetector(
                      child: CustomPaint(
                        size: Size(800, 720),
                        //maybe we can determine size dynamically using mediaQuery
                        painter: DrawingPainter(
                          pointsList: state.drawingPoints,
                          recorder: state.recorder,
                        ),
                      ),
                      onPanStart: (details) {
                        snapCubit.addDrawingPoints(
                            globalPosition: details.globalPosition,
                            context: context);
                      },
                      onPanEnd: (details) {
                        snapCubit.endStroke();
                      },
                      onPanUpdate: (details) {
                        snapCubit.addDrawingPoints(
                            globalPosition: details.globalPosition,
                            context: context);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 80),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xffff7da9),
                            minimumSize: Size(400, 70),
                          ),
                          onPressed: () async => {await snapCubit.submitSnap()},
                          child: const Text(
                            'Place snap in snapcup!',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Card(
                  color: Color.fromARGB(25, 255, 2555, 255),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'S N A P C U P',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          GestureDetector(
                            child: const Image(
                              image: AssetImage('assets/images/pinkCup.png'),
                              width: 350,
                              height: 450,
                            ),
                          ),
                          const Text("2",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 60))
                        ],
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xffff7da9)),
                        ),
                        onPressed: () async => {await snapCubit.pickSnap()},
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 45.0,
                            vertical: 15,
                          ),
                          child: Text(
                            "Read a snap",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
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
