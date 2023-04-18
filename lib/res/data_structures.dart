class Blog {
  final String id;
  int reads;
  final String title;
  final String content;
  final String author;
  final String genre;
  var isVerified = false;
  int score;

  Blog(
      {required this.id,
      this.reads = 0,
      required this.title,
      required this.content,
      required this.author,
      required this.genre,
      required this.isVerified,
      this.score = 1400});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'author': author,
        'reads': reads,
        'genre': genre,
        'isVerified': isVerified,
      };

  static Blog fromJson(Map<String, dynamic> json) => Blog(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        author: json['author'],
        genre: json['genre'],
        reads: json['reads'],
        isVerified: json['isVerified'],
      );
}

class Issue {
  final String issueDescription;

  Issue({required this.issueDescription});

  Map<String, dynamic> toJson() => {
        'issue': issueDescription,
      };
}
