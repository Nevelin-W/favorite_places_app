import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import '../model/place.dart';

Future<Database> _getDb() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, adresss TEXT)');
    },
    version: 1,
  );
  return db;
}

class PlacesProvider extends StateNotifier<List<Place>> {
  PlacesProvider() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDb();
    final data = await db.query('user_places');
    final place = data
        .map(
          (row) => Place(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            location: PlaceLocation(
              latitude: row['lat'] as double,
              longitude: row['lng'] as double,
              address: row['adresss'] as String,
            ),
          ),
        )
        .toList();

    state = place;
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$fileName');

    final newPLace = Place(
      title: title,
      image: copiedImage,
      location: location,
    );

    final db = await _getDb();
    db.insert(
      'user_places',
      {
        'id': newPLace.id,
        'title': newPLace.title,
        'image': newPLace.image.path,
        'lat': newPLace.location!.latitude,
        'lng': newPLace.location!.longitude,
        'adresss': newPLace.location!.address,
      },
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    state = [newPLace, ...state];
  }
}

final placesProvider = StateNotifierProvider<PlacesProvider, List<Place>>(
  (ref) => PlacesProvider(),
);
