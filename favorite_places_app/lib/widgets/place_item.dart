import 'package:flutter/material.dart';
import 'package:favorite_places_app/model/place.dart';
import 'package:favorite_places_app/screen/place_details.dart';

class PlaceItem extends StatelessWidget {
  const PlaceItem({super.key, required this.item});

  final Place item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: FileImage(item.image),
        ),
        dense: true,
        contentPadding: const EdgeInsets.only(left: 17, top: 5),
        title: Text(
          item.title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w400),
        ),
        subtitle: Text(item.location!.address),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => PlaceDetailScreen(item: item),
          ));
        },
      ),
    );
  }
}
