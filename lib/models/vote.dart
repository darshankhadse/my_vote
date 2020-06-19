class Vote{
  String voteId;
  String voteTitle;
  List<Map<String,int>> options;
  Vote({this.voteId,this.voteTitle,this.options});
}

class Voter{
  String uidl;
  String voteId;
  int markedVoteOption;

}