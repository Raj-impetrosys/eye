import '../index.dart';

radioButton(
        {required dynamic value,
        required dynamic groupValue,
        required void Function(dynamic)? onChanged,
        required String text}) =>
    Row(
      children: [
        Radio(value: value, groupValue: groupValue, onChanged: onChanged),
        Text(text)
      ],
    );