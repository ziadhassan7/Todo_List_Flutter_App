import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list_app/model/task_model.dart';

import 'constants.dart';

class DatabaseProvider {
  static final DatabaseProvider instance = DatabaseProvider._init();

  DatabaseProvider._init();

  static Database? _database;

  Future<Database>? get database async{

    if(_database != null) _database;

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async{
    String path = join(await getDatabasesPath(), 'TaskDatabase.db');
    return await openDatabase(path, version: 33, onCreate: _createDB);
  }

  Future<void> _createDB(Database database, int version) async {
    await database.execute('''  
    CREATE TABLE $tableTasks (
    $columnId $idType,
    $columnTitle $textType,
    $columnDetail $textType,
    $columnCheckStatus $intType,
    $columnDay $intType,
    $columnMonth $intType,
    $columnYear $intType
    )
    ''');
  }


  /// CRUD

  // Create
  Future<void> createNote(TaskModel noteModel) async {
    final db = await instance.database;

    db!.insert(
      tableTasks,
      noteModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Update
  Future<void> updateNote(TaskModel noteModel) async {
    final db = await instance.database;

    db!.update(
      tableTasks,
      noteModel.toMap(),
      where: '$columnId = ?',
      whereArgs: [noteModel.id],
    );
  }

  // Delete
  Future<void> deleteNote(int? id) async {
    final db = await instance.database;

    db!.delete(
      tableTasks,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Read One Element
  Future<TaskModel> readOneElement(int? id) async {
    final db = await instance.database;

    final data = await db!.query(
      tableTasks,
      where: '$columnId = ?',
      whereArgs: [id],
    );

    return data.isNotEmpty
        ? TaskModel.fromMap(data.first)
        : throw Exception('There is no data');
  }


  // Read All Elements
  Future<List<TaskModel>> readAllElements() async {
    final db = await instance.database;

    final data = await db!.query(tableTasks);

    return data.isNotEmpty
        ? data.map((task) => TaskModel.fromMap(task)).toList()
        : [];
  }
}