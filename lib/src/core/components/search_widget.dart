import 'package:flutter/material.dart';

import '../styles/app_color.dart';
import '../styles/app_text_styles.dart';

class SearchWidget extends StatefulWidget {
  final ValueChanged<String> searchChange;
  const SearchWidget({Key? key, required this.searchChange}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  bool showClose = false;
  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      height: 32,
      child: TextFormField(
        onChanged: (value) {
          if(value.isNotEmpty){
            setState(() {
              showClose = true;
            });
          } else {
            setState(() {
              showClose = false;
            });
          }
          widget.searchChange(value);
        },
        decoration: InputDecoration(
          fillColor: context.appColor.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.fromLTRB(15, 11, 8, 11),
          isCollapsed: true,
          hintText: 'Search',
          hintStyle: context.appTextStyles.body3
              .copyWith(color: context.appColor.medium),
          suffixIcon: Visibility(
            visible: showClose,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
              child: Image.asset(
                'assets/icons/close.png',
                color: context.appColor.primary,
                height: 9,
                width: 9,
              ),
            ),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
            child: Image.asset(
              'assets/icons/search.png',
              color: context.appColor.primary,
              height: 11.78,
              width: 11.8,
            ),
          ),
        ),
      ),
    );
  }
}
