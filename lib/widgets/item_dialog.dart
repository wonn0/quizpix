import 'package:flutter/material.dart';

class ItemDialog extends StatelessWidget {
  const ItemDialog({
    super.key,
    required this.boQuantity,
    required this.reQuantity,
    required this.frQuantity,
    required this.onBonus,
    required this.onRedo,
    required this.onPass,
    required this.correctAnswer,
  });

  final int boQuantity;
  final int reQuantity;
  final int frQuantity;
  final Function() onBonus;
  final Function() onRedo;
  final Function(String) onPass;
  final String correctAnswer;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
      contentPadding: const EdgeInsets.only(
          left: 20.0, top: 20.0, right: 20.0, bottom: 32.0),
      title: const Center(
        child: Text(
          'Use an Item',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color(0xfff69036),
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    height: 50.0,
                    child: Image.asset('assets/images/potion_blue.png',
                        fit: BoxFit.fitHeight)),
                const SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Bonus Potion",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            color: Color(0xfff69036))),
                    Text("Quantity: $boQuantity",
                        style: const TextStyle(
                            fontSize: 12.0, color: Color(0xff909090))),
                  ],
                ),
                const Spacer(flex: 1),
                ElevatedButton(
                  onPressed: () {
                    if (boQuantity > 0) {
                      onBonus();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(32, 32),
                    backgroundColor: const Color(0xfff69036),
                    elevation: 0,
                  ),
                  child: const Text("Use",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16.0)),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    height: 50.0,
                    child: Image.asset('assets/images/potion_green.png',
                        fit: BoxFit.fitHeight)),
                const SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Redo Potion",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            color: Color(0xfff69036))),
                    Text("Quantity: $reQuantity",
                        style: const TextStyle(
                            fontSize: 12.0, color: Color(0xff909090))),
                  ],
                ),
                const Spacer(flex: 1),
                ElevatedButton(
                  onPressed: () {
                    if (reQuantity > 0) {
                      onRedo();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(32, 32),
                    backgroundColor: const Color(0xfff69036),
                    elevation: 0,
                  ),
                  child: const Text("Use",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16.0)),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    height: 50.0,
                    child: Image.asset('assets/images/potion_red.png',
                        fit: BoxFit.fitHeight)),
                const SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Free Pass Potion",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            color: Color(0xfff69036))),
                    Text("Quantity: $frQuantity",
                        style: const TextStyle(
                            fontSize: 12.0, color: Color(0xff909090))),
                  ],
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (frQuantity > 0) {
                      onPass(correctAnswer);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(32, 32),
                    backgroundColor: const Color(0xfff69036),
                    elevation: 0,
                  ),
                  child: const Text("Use",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16.0)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
