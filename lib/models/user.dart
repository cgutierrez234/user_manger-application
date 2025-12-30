// This user model or class is pure dart language, doesn't need to import flutter shtuff.

class User {
  final String id;
  final String name;

  User({required this.id, required this.name});

  // Converts a User object toa Map<String, dynamic> for inserting into SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Takes a database row(a Map) and turns it back into a User Object
  factory User.fromMap(Map<String, dynamic> map) {
    return User (
      id: map['id'],
      name: map['name'],
    );
  }
}
