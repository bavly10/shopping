class lanugage{
  int? id;
  String? name,flag;
  late String lang_Code;

  lanugage({this.id, this.name, this.flag, required this.lang_Code});

  static List<lanugage> lang_list=[
    lanugage(id: 1,name: "English",flag:"π¬π§" ,lang_Code: "en"),
    lanugage(id: 2,name: "Saudi Arabia",flag:"πΈπ¦" ,lang_Code: "ar"),
  ];
}