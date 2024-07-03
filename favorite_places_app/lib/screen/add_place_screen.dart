import 'package:flutter/material.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
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
          centerTitle: true,
          title: const Text('Add new Place'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(11),
          child: Form(
              child: Column(
            children: [
              TextFormField(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
                decoration: titleFormFieldDec,
                cursorColor: Theme.of(context).colorScheme.secondaryFixed,
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
                onPressed: () {},
                child: const Text('Add Place', style: TextStyle(fontSize: 15)),
              )
            ],
          )),
        ));
  }
}
