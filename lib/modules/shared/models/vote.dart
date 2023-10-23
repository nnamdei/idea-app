class Vote {
  final int? id;
  final int ideaId;
  final int userId;
  final bool isUpvote;

  Vote({
    this.id,
    required this.ideaId,
    required this.userId,
    required this.isUpvote,
  });
}