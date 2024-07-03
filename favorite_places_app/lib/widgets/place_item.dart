import 'package:favorite_places_app/model/place.dart';
import 'package:flutter/material.dart';

class PlaceItem extends StatelessWidget {
  const PlaceItem({super.key, required this.item});

  final Place item;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.only(left: 17, top: 5),
        title: Text(item.title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w400)),
      ),
    );
  }
}
