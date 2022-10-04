import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapcup/models/drawing_painter.dart';
import 'package:snapcup/widgets/color_picker_dialog.dart';
import 'package:snapcup/styles/styles.dart';
import 'package:snapcup/widgets/read_a_snap_dialog.dart';
import 'bloc/bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController snapController = TextEditingController();
    final snapCubit = context.read<SnapCubit>();
    return BlocConsumer<SnapCubit, SnapState>(
      listener: ((context, state) async {
        if (state.readASnapDialogIsVisible) {
          await showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return ReadASnapDialog(
                    message: state.selectedSnap!.message,
                    imageBytes: state.selectedSnap!.imageData!);
              });
        }
      }),
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
                        color: const Color(0xffff7da9),
                        child: TextField(
                          controller: snapController,
                          maxLines: 5,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 10, top: 10),
                              hintText: "Snaps to Parahat for...",
                              hintStyle: TextStyle(
                                fontSize: 20,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2))),
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
                                        selectedColor: state.selectedColor,
                                        onColorChanged: (Color color) {
                                          snapCubit.changeColor(color);
                                          return color;
                                        });
                                  });
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StrokeCircle(
                            newWidth: 4,
                            size: 18,
                            oldWidth: state.selectedStrokeWidth,
                            selectedColor: state.selectedColor),
                        const SizedBox(
                          width: 5,
                        ),
                        StrokeCircle(
                            newWidth: 8,
                            size: 26,
                            oldWidth: state.selectedStrokeWidth,
                            selectedColor: state.selectedColor),
                        const SizedBox(
                          width: 5,
                        ),
                        StrokeCircle(
                            newWidth: 15,
                            size: 32,
                            oldWidth: state.selectedStrokeWidth,
                            selectedColor: state.selectedColor),
                        const SizedBox(
                          width: 5,
                        ),
                        StrokeCircle(
                            newWidth: 25,
                            size: 38,
                            oldWidth: state.selectedStrokeWidth,
                            selectedColor: state.selectedColor),
                      ],
                    ),
                    GestureDetector(
                      child: CustomPaint(
                          size: Size(700, 600),
                          //maybe we can determine size dynamically using mediaQuery
                          //todo readd this and make it work
                          // painter: state.painter),
                          painter:
                              DrawingPainter(pointsList: state.drawingPoints)),
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
                      const Image(
                        image: AssetImage('images/logo.png'),
                        // width: 350,
                        // height: 450,
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
                          Text(state.snapCount.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 60))
                        ],
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xffff7da9)),
                        ),
                        onPressed: () async => {
                          state.snapCount > 0
                              ? await snapCubit.pickSnap()
                              : null
                        },
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

class StrokeCircle extends StatelessWidget {
  final double newWidth;
  final double oldWidth;
  final double size;
  final Color selectedColor;
  const StrokeCircle({
    super.key,
    required this.newWidth,
    required this.oldWidth,
    required this.size,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final snapCubit = context.read<SnapCubit>();
    return Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(
                color: oldWidth == newWidth ? Colors.black : Colors.white,
                width: 2.0),
            color: selectedColor,
            shape: BoxShape.circle,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(1000.0),
            onTap: () {
              snapCubit.changeStrokeWidth(newWidth);
            },
            child: Icon(
              Icons.circle,
              size: size,
              color: selectedColor,
            ),
          ),
        ));
  }
}
