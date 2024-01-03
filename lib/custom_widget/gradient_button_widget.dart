import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  const GradientButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: InkWell(
          onTap: () {
            onTap();
          },
          child: Container(
              height: 38,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  gradient: const LinearGradient(colors: [
                    Color.fromRGBO(238, 50, 56, 1),
                    Color.fromRGBO(238, 51, 56, 0.5899999737739563)
                  ]),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.withOpacity(0.2),
                      spreadRadius: 6,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ]),
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Avenir',
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
