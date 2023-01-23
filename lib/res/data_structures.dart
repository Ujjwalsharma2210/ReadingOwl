class Blog {
  String id;
  dynamic reads;
  final String title;
  final String content;
  final String author;
  final String genre;

  Blog({
    this.id = '',
    this.reads = 0,
    required this.title,
    required this.content,
    required this.author,
    required this.genre,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'author': author,
        'reads': reads,
        'genre': genre,
      };

  static Blog fromJson(Map<String, dynamic> json) => Blog(
      title: json['title'],
      content: json['content'],
      author: json['author'],
      genre: json['genre'],
      reads: json['reads']);
}
