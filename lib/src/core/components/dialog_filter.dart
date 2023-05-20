import 'package:flutter/material.dart';

import '../styles/app_color.dart';
import '../styles/app_text_styles.dart';

enum Filter { number, name }

class DialogFilter extends StatefulWidget {
  final void Function(Filter? filter) onPressed;
  final Filter? value;
  const DialogFilter({super.key, required this.onPressed, this.value});

  @override
  State<DialogFilter> createState() => _DialogFilterState();
}

class _DialogFilterState extends State<DialogFilter> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: context.appColor.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 42, 16),
              child: Text(
                'Sort by:',
                style: context.appTextStyles.subtitle2
                    .copyWith(color: context.appColor.white),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: context.appColor.white,
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  RadioListTile<Filter>(
                    value: Filter.number,
                    activeColor: context.appColor.primary,
                    title: Text(
                      'Number',
                      style: context.appTextStyles.body3.copyWith(
                        color: context.appColor.dark,
                      ),
                    ),
                    groupValue: widget.value,
                    onChanged: (value) {
                      Navigator.of(context).pop();
                      widget.onPressed(value);
                      
                    },
                  ),
                  RadioListTile<Filter>(
                    value: Filter.name,
                    activeColor: context.appColor.primary,
                    title: Text(
                      'Name',
                      style: context.appTextStyles.body3.copyWith(
                        color: context.appColor.dark,
                      ),
                    ),
                    groupValue: widget.value,
                    onChanged: (value) {
                      Navigator.of(context).pop();
                      widget.onPressed(value);
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
