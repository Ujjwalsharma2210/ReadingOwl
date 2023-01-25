class Blog {
  String id;
  dynamic reads;
  final String title;
  final String content;
  final String author;
  final String genre;
  bool isVerified;

  Blog({
    this.id = '',
    this.reads = 0,
    required this.title,
    required this.content,
    required this.author,
    required this.genre,
    this.isVerified = false,
  });

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
      title: json['title'],
      content: json['content'],
      author: json['author'],
      genre: json['genre'],
      reads: json['reads'],
      isVerified: json['isVerified']);
}
