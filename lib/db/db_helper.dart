import 'package:flutter/cupertino.dart';
import 'package:montage/db/post_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'montage.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Post (id TEXT PRIMARY KEY, title TEXT,_id TEXT,description TEXT,status TEXT,image TEXT,userId TEXT,type TEXT)');
  }

  Future<Post> add(Post post) async {
    var dbClient = await db;
    await dbClient.insert('Post', post.toMap());
    return post;
  }

  Future<List<Post>> getPosts() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('Post',
        columns: [
          'id',
          'title',
          '_id',
          'description',
          'status',
          'image',
          'userId',
          'type'
        ],
        orderBy: "id DESC");
    List<Post> posts = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        posts.add(Post.fromMap(maps[i]));
      }
    }
    return posts;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'Post',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Post> getPostById(String id) async {
    var dbClient = await db;
    var result = await dbClient.query("Post", where: "id = ", whereArgs: [id]);
    return result.isNotEmpty ? Post.fromMap(result.first) : Null;
  }


  Future<Post> getPostByIdQuery(String id) async {
    var dbClient = await db;
    var result =
    await dbClient.rawQuery("SELECT * FROM Post where id=" + "" + "'"+id+"'" + ";");
    return result.isNotEmpty ? Post.fromMap(result.first) : Null;
  }

  Future<int> update(Post post) async {
    try{
      debugPrint(post.id);
      var dbClient = await db;

      return await dbClient.update(
        'Post',
        post.toMap(),
        where: 'id = ?',
        whereArgs: [post.id],
      );
    }on Exception catch (_) {
      print('never reached');
    }

  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
