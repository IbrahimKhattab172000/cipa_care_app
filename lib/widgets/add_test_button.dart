import 'package:cipa_care_app/constants/constants.dart';
import 'package:flutter/material.dart';

class FetchTestButton extends StatelessWidget {
  final VoidCallback onTap;
  const FetchTestButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: onTap,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(cellColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ),
                  side: const BorderSide(color: Colors.white),
                ),
              ),
            ),
            child: const Text('Recieve recommendation'),
          ),
        ),
      ],
    );
  }
}
