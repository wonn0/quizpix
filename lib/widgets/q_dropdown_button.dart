import 'package:flutter/material.dart';

class QDropdownButton extends StatefulWidget {
  const QDropdownButton({super.key, required this.isSort});

  final bool isSort;

  @override
  State<QDropdownButton> createState() => _QDropdownButtonState();
}

class _QDropdownButtonState extends State<QDropdownButton> {
  final List<String> sortList = ['no sort', 'by date', 'by views', 'by rating'];
  final List<String> filterList = ['no filter', 'title', 'author', 'subject'];

  String? dropdownValue;
  List<String> dropdownItems = [];

  @override
  void initState() {
    super.initState;
    dropdownValue = widget.isSort ? sortList.first : filterList.first;
    dropdownItems = widget.isSort ? sortList : filterList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(4.0, 4.0),
            spreadRadius: 1,
            blurRadius: 12,
          ),
        ],
        color: const Color(0xfffafafa),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
            value: dropdownValue,
            items: dropdownItems.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    color: Color(0xff6d5271),
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                dropdownValue = value;
              });
            },
            isDense: true,
            borderRadius: BorderRadius.circular(16.0),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Color(0xff6d5271),
            ),
          ),
        ),
      ),
    );
  }
}
