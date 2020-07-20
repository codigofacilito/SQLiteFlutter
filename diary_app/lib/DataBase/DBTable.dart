class DBTable {
  static const DIARY = "diary";
  static const PAGE = "page";
  static const TABLES =
  [
    "CREATE TABLE IF NOT EXISTS " + DIARY +
        "("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "type TEXT,"
          "enterCode TEXT"
        ")",
    "CREATE TABLE IF NOT EXISTS " + PAGE +
        "("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "date TEXT,"
            "title TEXT,"
            "content TEXT,"
            "diaryId INTEGER,"
            "FOREIGN KEY(diaryId) REFERENCES "+DIARY+"(id)"
            ")",
  ];
}