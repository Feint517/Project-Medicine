import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:intl/intl.dart';

class TestingPage extends StatelessWidget {
  const TestingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: const Icon(Iconsax.add),
        onPressed: () {
          Navigator.of(context).push(
            showPicker(
              context: context,
              value: Time(hour: 20, minute: 40),
              sunrise: const TimeOfDay(hour: 6, minute: 0), // optional
              sunset: const TimeOfDay(hour: 18, minute: 0), // optional
              duskSpanInMinutes: 120, // optional
              onChange: (onTimeChanged) {},
              onChangeDateTime: (time) {
                String formattedTime = DateFormat.Hm().format(time);
                print(formattedTime);
              },
            ),
          );
        },
      ),
    );
  }
}
