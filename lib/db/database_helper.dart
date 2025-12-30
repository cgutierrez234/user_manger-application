import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user.dart';

// Flutter apps often use a singleton pattern for database access, so you only open the database once

class DatabaseHelper {

  // Ensures only one instance of DatabaseHelper is in the application. 
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

static Database? _database;


// Database GETTER . Checks if that database is already open. If yes, then just return it If no, call _initDatabase to create/open it. Ensures it is opened only once and reused throughout the application.
Future<Database> get database async {
  if (_database != null) return _database!;
  _database = await _initDatabase();
  return _database!;
  }


  // Initializes the database. Gets the default location for the databases( each OS has its own directory) Combines that with the file name for a safe path.
  Future<Database> _initDatabase() async {
    // Get the default database location on the device
    final dbPath = await getDatabasesPath();

    // Combine the path with the database file name
    final path = join(dbPath, 'user_manager.db');
    
    // Open the database (or create it if it doesn't exist) onCreate only runs once when the DB is first made. Inside we have defined the schema.
    return await openDatabase(
      path, 
      version:1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id TEXT PRIMARY KEY,
            name TEXT
          )
        ''');
      },
    );
  }

  // CREATE 

  Future<void> insertUser(User user) async {
    final db = await database; // gets the singleton database instance(from the getter we wrote)
    await db.insert ( // inserts the row into the users table
      'users',
      user.toMap(), // converts the Dart object into something SQLite understands
      conflictAlgorithm: ConflictAlgorithm.replace, // if the user already exists, just replaces without throwing an error
    );
  }

  // READ
  Future<List<User>> getUsers() async {
  final db = await database; // gets the singleton database instance
  final List<Map<String, dynamic>> maps = await db.query('users'); // runs SELECT * FROM users and returns a List of User Objects in map form
  
  return List.generate(maps.length, (i) { // loops over those map object and converts them back to User objects with fromMap
    return User.fromMap(maps[i]);
    });
  }

  // READ (Get user by id)
  Future<User?> getUserById(String id) async { // the ? means that User can be null. The return can be nullable
    final db = await database;
    final List<Map<String,dynamic>> maps = 
    await db.query('users', where: 'id = ?', whereArgs: [id]); // runs a SQL SELECT query WHERE clause. whereArgs: [id] prevents SQL injection by "injecting" the id at SQL query time. 

    if(maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // UPDATE
  Future<void> updateUser(User user) async {
    final db = await database; 

    await db.update(
      'users', // table name
      user.toMap(), // turn that object into a map for the DB
      where: 'id = ?', // SQL WHERE clause
      whereArgs: [user.id] // safely inset the id here to prevent SQL injection.
    );
  }

  // DELETE
  Future<void> deleteUser(String id) async {
    final db = await database;

    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}