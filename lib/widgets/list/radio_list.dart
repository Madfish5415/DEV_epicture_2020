import 'package:flutter/material.dart';

class RadioListWidget<T> extends StatefulWidget {
  final Widget title;
  final T currentValue;
  final Map<T, Widget> list;
  final ValueChanged<T> onChanged;

  RadioListWidget({
    @required this.title,
    @required this.currentValue,
    @required this.list,
    @required this.onChanged,
  });

  @override
  _RadioListState<T> createState() => _RadioListState<T>();
}

class _RadioListState<T> extends State<RadioListWidget<T>> {
  T group;

  @override
  void initState() {
    super.initState();

    group = widget.currentValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.title,
      ]..addAll(widget.list.keys.map((key) {
        return RadioListTile(
          title: widget.list[key],
          value: key,
          groupValue: group,
          onChanged: (value) {
            _change(value);
            widget.onChanged(value);
          },
        );
      })),
    );
  }

  _change(T value) {
    setState(() {
      group = value;
    });
  }
}
