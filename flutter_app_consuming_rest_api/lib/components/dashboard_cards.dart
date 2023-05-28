import 'package:flutter/material.dart';

class DashboardCards extends StatelessWidget {
  const DashboardCards({
    Key? key,
    required this.titleCardText,
    required this.valueCardText,
  }) : super(key: key);

  final String titleCardText;
  final String valueCardText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 85,
        decoration: const BoxDecoration(
            color: Color(0xFFE0E0E0),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 18),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 20,
                child: Row(
                  children: [
                    const Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 15,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      titleCardText,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 9, top: 3, bottom: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 25,
                child: Text(
                  valueCardText,
                  style: const TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
