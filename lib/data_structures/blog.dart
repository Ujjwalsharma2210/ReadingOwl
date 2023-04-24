class Blog {
  String id;
  int reads;
  String title;
  String content;
  String author;
  String genre;
  var isVerified;
  int score;

  Blog(
      {required this.id,
      required this.reads,
      required this.title,
      required this.content,
      required this.author,
      required this.genre,
      required this.isVerified,
      required this.score});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'author': author,
        'reads': reads,
        'genre': genre,
        'isVerified': isVerified,
        'score': score,
      };

  static Blog fromJson(Map<String, dynamic> json) => Blog(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        author: json['author'],
        genre: json['genre'],
        reads: json['reads'],
        isVerified: json['isVerified'],
        score: json['score'],
      );
}
