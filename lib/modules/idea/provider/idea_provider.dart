import 'package:flutter/material.dart';
import 'package:idea/modules/shared/models/idea.dart';
import 'package:idea/modules/shared/util/db_helper.dart';
import 'package:idea/modules/shared/util/db_util.dart';
import 'package:idea/modules/shared/view_state.dart';

class IdeaProvider extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  AppState get appState => _appState;
  AppState _appState = AppState.initial;
  DatabaseProvider? databaseProvider;
  DBUtil dbHelper = DBUtil();

  Idea? _idea, detail;
  Idea? get newIdea => _idea;
  List<Idea> idea = [];

  bool _isCreated = false;
  bool get isCreated => _isCreated;

  bool _isButtonEnabled = false;
  bool get isButtonEnabled => _isButtonEnabled;
  void updateButtonState(String value) {
    _isButtonEnabled = value.isNotEmpty;
    notifyListeners();
  }

  Future<Idea?> fetchIdea(int id) async {
    detail = await dbHelper.getIdea(id);
    notifyListeners();
    return detail;
  }

  Future<List<Idea>> getData() async {
    idea = await dbHelper.getIdeaList();
    notifyListeners();
    return idea;
  }

  void upVote(int id) async {
    final index = idea.indexWhere((element) => element.id == id);
    idea[index].upvotes!.value = idea[index].upvotes!.value + 1;
    await dbHelper.upvoteIdea(Idea(
      id: idea[index].id,
      upvotes: ValueNotifier(idea[index].upvotes!.value + 1),
    ));
    // _setPrefsItems();
    notifyListeners();
  }

  void downVote(int id) async {
    final index = idea.indexWhere((element) => element.id == id);
    idea[index].downvotes!.value = idea[index].downvotes!.value + 1;

    await dbHelper.downvoteIdea(Idea(
      id: idea[index].id,
      downvotes: ValueNotifier(idea[index].downvotes!.value + 1),
    ));
    // _setPrefsItems();
    notifyListeners();
  }

  void saveIdeaToDb(String description, String title) {
    dbHelper
        .insertIdea(
      Idea(
        // id: index,
        description: description,
        title: title,
        upvotes: ValueNotifier(0),
        downvotes: ValueNotifier(0),
      ),
    )
        .then((value) {
      _isCreated = true;
      notifyListeners();
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
}
