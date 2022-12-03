import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(4.0, 4.0),
              spreadRadius: 1,
              blurRadius: 12),
        ],
      ),
      child: TextField(
        maxLines: 1,
        style: const TextStyle(
          color: Color(0xff909090),
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xfffafafa),
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          contentPadding: const EdgeInsets.only(
            left: 20.0,
            top: 12.0,
            right: 4.0,
            bottom: 12.0,
          ),
          hintText: 'Search for a quiz...',
          hintStyle: const TextStyle(
            color: Color(0xffd3d3d3),
          ),
          suffixIcon: const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.search_outlined,
              size: 30.0,
              color: Color(0xffd3d3d3),
            ),
          ),
        ),
      ),
    );
  }
}
