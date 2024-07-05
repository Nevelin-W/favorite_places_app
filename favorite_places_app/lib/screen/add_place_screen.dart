import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places_app/providers/places_provider.dart';
import 'package:favorite_places_app/widgets/image_input.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final TextEditingController _titleController = TextEditingController();
  File? _selectedImage;

  void _savePlace() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty || enteredTitle.trim().isEmpty) {
      return;
    }
    ref.read(placesProvider.notifier).addPlace(enteredTitle, _selectedImage!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final InputDecoration titleFormFieldDec = InputDecoration(
      filled: true,
      fillColor: Theme.of(context).colorScheme.secondaryContainer,
      labelText: 'Title',
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.primaryFixed,
        fontSize: 17,
      ),
      border: const OutlineInputBorder(
        gapPadding: 7,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context)
              .colorScheme
              .secondaryFixed
              .withOpacity(0.8), // Set the fill color here
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          elevation: 3,
          shadowColor: Theme.of(context).colorScheme.shadow,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          centerTitle: true,
          title: const Text('Add new Place'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(11),
          child: Form(
              child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
                decoration: titleFormFieldDec,
                cursorColor: Theme.of(context).colorScheme.secondaryFixed,
              ),
              const SizedBox(
                height: 15,
              ),
              ImageInput(
                onPickImage: (image) {
                  _selectedImage = image;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  elevation: 5,
                  shadowColor: Theme.of(context).colorScheme.shadow,
                  surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
                  backgroundColor: Theme.of(context).colorScheme.primaryFixed,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: const StadiumBorder(),
                ),
                onPressed: _savePlace,
                child: const Text(
                  'Add Place',
                  style: TextStyle(fontSize: 15),
                ),
              )
            ],
          )),
        ));
  }
}
