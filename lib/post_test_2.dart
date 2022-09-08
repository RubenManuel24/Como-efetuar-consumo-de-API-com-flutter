class PostTest2 {
  int _userId;
  int _id;
  String _title;
  String _body;

  PostTest2(this._userId, this._id, this._body, this._title);

  int get getUserId{
    return _userId;
  }

  set setUserId(int userId){
    _userId = userId;
  }

  int get getId{
    return _id;
  }

  set setId(int id){
    _id = id;
  }

  String get getTitle{
    return _title;
  }

  set setTitle(String title){
    _title = title;
  }

  String get getBody{
    return _body;
  }

  set setBody(String body){
    _body = body;
  }

}
