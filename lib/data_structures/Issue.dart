class Issue {
  final String issueDescription;

  Issue({required this.issueDescription});

  Map<String, dynamic> toJson() => {
        'issue': issueDescription,
      };
}
