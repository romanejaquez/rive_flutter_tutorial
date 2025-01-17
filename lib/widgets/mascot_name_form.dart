import 'package:flutter/material.dart';
import 'package:rive_app/widgets/mascot_head.dart';
import 'package:rive_app/widgets/mascot_icon.dart';

class MascotNameForm extends StatefulWidget {

  final Function(String) onUpdatedName;
  final ValueNotifier<String> name;
  const MascotNameForm({super.key, required this.name, required this.onUpdatedName});

  @override
  State<MascotNameForm> createState() => _MascotNameFormState();
}

class _MascotNameFormState extends State<MascotNameForm> {

  TextEditingController nameController = TextEditingController();
  String mascotName = '';

  @override  
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 100,
            left: 32,
            right: 32,
            bottom: 32,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 12,
            children: [
              Text('Enter the name of your mascot:', textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.blueAccent),
              ),
              TextFormField(
                controller: nameController,
                maxLength: 20,
                maxLines: 1,
                minLines: 1,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                onChanged: (value) {
                  setState(() {
                    nameController.text = value;
                    mascotName = value;
                  });
                },
              ),
              ElevatedButton.icon(
                icon: MascotIcon(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.all(8),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)
                ),
                onPressed: () {
                  widget.onUpdatedName(mascotName);
                },
                label: Text('Your Mascot Name'),
              ),
              const SizedBox(height: 48,)
            ],
          ),
        ),

        Positioned(
          left: 0, right: 0,
          top: -100,
          child: MascotHead(),
        )
      ],
    );
  }
}