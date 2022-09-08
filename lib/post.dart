class Post{

  int _userId;
  int _id;
  String _title;
  String _body;
  
  Post(this._userId, this._id, this._title, this._body);

  int get getuserId => _userId;

  
  set userId(int userId){
    _userId=userId;
  }
  
  int get getid => _id;

  set setid(int id){
    _id = id;
  }

  String get gettile => _title;

  set settitle(String title){
    _title = title;
  }

  String get getbody => _body;

  set setbody(String body){
    _body=body;
  }



}